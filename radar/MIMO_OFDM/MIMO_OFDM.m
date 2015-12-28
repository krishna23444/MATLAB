%------------------------------------------
% EE359 final project, Fall 2002
% Channel estimation for a MIMO-OFDM system
% By Shahriyar Matloub               
%------------------------------------------

clear all;
%close all;

Rayleigh=1;
AWGN=0;                             % for AWGN channel 
MMSE=0;                             % estimation technique
Nsc=64;                             % Number of subcarriers
Ng=16;                              % Cyclic prefix length
SNR_dB=[0 5 10 15 20 25 30 35 40];  % Signal to noise ratio
Mt=2;                               % Number of Tx antennas
Mr=2;                               % Number of Rx antennas
pilots=[1:Nsc/Ng:Nsc];              % pilot subcarriers 
DS=15;                              % Delay spread of channel
iteration_max=200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Channel impulse response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (Rayleigh)
    N=50;
    fm=100; %最大值
    B=20e3;
    fd=(rand(1,N)-0.5)*2*fm; %幅度
    theta=randn(1,N)*2*pi;
    c=randn(1,N);
    c=c/sum(c.^2);
    t=0:fm/B:10000*fm/B;
    Tc=zeros(size(t));
    
    Ts=zeros(size(t));
    for k=1:N
       Tc=c(k)*cos(2*pi*fd(k)*t+theta(k))+Tc;
       Ts=c(k)*sin(2*pi*fd(k)*t+theta(k))+Ts;
    end
    r=ones(Mt*Mr,1)*(Tc.^2+Ts.^2).^0.5;
    index=floor(rand(Mt*Mr,DS)*5000+1);
end

MEE1=zeros(1,length(SNR_dB));
MEE2=zeros(1,length(SNR_dB));

for snrl=1:length(SNR_dB)
    snrl
    estimation_error1=zeros(Mt*Mr,Nsc);
    estimation_error2=zeros(Mt*Mr,Nsc);
    R1=besselj(0,2*pi*fm*(Nsc+Ng)/B);
    sigma2=10^(-SNR_dB(snrl)/10);
    aa=(1-R1^2)/(1-R1^2+sigma2);
    bb=sigma2*R1/(1-R1^2+sigma2);

    for iteration=1:iteration_max
        %iteration    
        if AWGN==1
            h=ones(Mt*Mr,1);
        else
            phi=rand*2*pi;
            h=r(index+iteration)*exp(i*phi);
            %h=rand(Mt*Mr,DS);
            h=h.*(ones(Mt*Mr,1)*(exp(-0.5).^[1:DS]));
            h=h./(sqrt(sum(abs(h).^2,2))*ones(1,DS));
        end



        CL=size(h,2);                                               % channel length
        data_time=zeros(Mt,Nsc+Ng);
        data_qam=zeros(Mt,Nsc);
        data_out=zeros(Mr,Nsc);
        output=zeros(Mr,Nsc);

        for tx=1:Mt
            data_b=0*round(rand(4,Nsc));                                  % data
            data_qam(tx,:)=i*(2*(mod(data_b(1,:)+data_b(2,:),2)+2*data_b(1,:))-3)+...
            2*(mod(data_b(3,:)+data_b(4,:),2)+2*data_b(3,:))-3;
            for loop=1:Mt 
                data_qam(tx,pilots+loop-1)=(1+i)*(loop==tx);              % pilots
            end
            data_time_temp=ifft(data_qam(tx,:));
            data_time(tx,:)=[data_time_temp(end-Ng+1:end) data_time_temp];
        end
    
        for rx=1:Mr
            for tx=1:Mt
                output_temp=conv(data_time(tx,:),h((rx-1)*Mt+tx,:));
                output(rx,:)=output_temp(Ng+1:Ng+Nsc)+output(rx,:);
            end
            np=(sum(abs(output(rx,:)).^2)/length(output(rx,:)))*sigma2;
            noise=(randn(size(output(rx,:)))+i*randn(size(output(rx,:))))*sqrt(np);
            output(rx,:)=output(rx,:)+noise;
            data_out(rx,:)=fft(output(rx,:));
        end

%%%%%%%%%%%%%%%%%%%%%%
% Channel estimation %
%%%%%%%%%%%%%%%%%%%%%%
    
        H_act=zeros(Mt*Mr,Nsc);
        H_est1=zeros(Mt*Mr,Nsc);
        H_est2=zeros(Mt*Mr,Nsc);

        i=1;
        for tx=1:Mt
            for rx=1:Mr
                H_est_temp=data_out(rx,pilots+tx-1)./data_qam(tx,pilots+tx-1);
                %H_est_temp2=aa*abs(H_est_temp1)+bb*abs(H_est2((rx-1)*Mt+tx,:));
                h_time=ifft(H_est_temp);
                h_time=[h_time zeros(1,Nsc-length(h_time))];
                H_est1((rx-1)*Mt+tx,:)=fft(h_time);
                H_est2((rx-1)*Mt+tx,:)=((aa*abs(H_est1((rx-1)*Mt+tx,:))+bb*abs(H_est2((rx-1)*Mt+tx,:)))...
                    .*H_est1((rx-1)*Mt+tx,:))./abs(H_est1((rx-1)*Mt+tx,:));
                if (tx>1)
                    H_est1((rx-1)*Mt+tx,:)=[H_est1((rx-1)*Mt+tx,Nsc-tx+2:Nsc) H_est1((rx-1)*Mt+tx,1:Nsc-tx+1)];
                    H_est2((rx-1)*Mt+tx,:)=[H_est2((rx-1)*Mt+tx,Nsc-tx+2:Nsc) H_est2((rx-1)*Mt+tx,1:Nsc-tx+1)];    
                end
                H_act((rx-1)*Mt+tx,:)=fft([h((rx-1)*Mt+tx,:) zeros(1,Nsc-CL)]);
                error1=(abs(H_act((rx-1)*Mt+tx,:)-H_est1((rx-1)*Mt+tx,:)).^2);
                error2=(abs(H_act((rx-1)*Mt+tx,:)-H_est2((rx-1)*Mt+tx,:)).^2);
                %error=(abs(H_act((rx-1)*Mt+tx,:)-H_est((rx-1)*Mt+tx,:)).^2)./(abs(H_act((rx-1)*Mt+tx,:)).^2);
                estimation_error1((rx-1)*Mt+tx,:)=estimation_error1((rx-1)*Mt+tx,:)+error1;                 
                estimation_error2((rx-1)*Mt+tx,:)=estimation_error2((rx-1)*Mt+tx,:)+error2; 
                %subplot(Mt*Mr,3,i),plot([0:Nsc-1],abs(H_act((rx-1)*Mt+tx,:))); i=i+1;
                %subplot(Mt*Mr,3,i),plot([0:Nsc-1],abs(H_est((rx-1)*Mt+tx,:))); i=i+1;
                %subplot(Mt*Mr,3,i),plot([0:Nsc-1],abs(error)); i=i+1;
            end
        end  
    end
    estimation_error1=estimation_error1/iteration_max;
    estimation_error2=estimation_error2/iteration_max;
    %estimation_error=min(estimation_error,10*iteration_max*ones(size(estimation_error)));
    %for i=1:Mt*Mr
    %    subplot(Mt*Mr,2,2*i-1),plot([0:Nsc-1],estimation_error1(i,:));    
    %    subplot(Mt*Mr,2,2*i),plot([0:Nsc-1],estimation_error2(i,:));
    %end
    MEE1(snrl)=sum(sum(estimation_error1))/(Mt*Mr*Nsc);
    MEE2(snrl)=sum(sum(estimation_error2))/(Mt*Mr*Nsc);
end

%plot(SNR_dB,10*log10(MEE1));    
%hold on;
plot(SNR_dB,10*log10(MEE2),'r');

%H_act=fft([h zeros(1,Nsc-CL)]).';


%error1=(abs(H_act-H_est1).^2)./(abs(H_act).^2);
%error2=(abs(H_act-H_est2).^2)./(abs(H_act).^2);

%%%%%%%%%
% Plots %
%%%%%%%%%
%fig=4;
%i=1;



%subplot(fig,1,i),plot([0:length(H_act)-1],abs(H_act));    i=i+1;
%subplot(fig,1,i),plot([0:length(H_est1)-1],abs(H_est1));  i=i+1;
%subplot(fig,1,i),plot([0:length(H_est2)-1],abs(H_est2));  i=i+1;
%subplot(fig,1,i),plot([0:length(error1)-1],error1);       i=i+1;
%subplot(fig,1,i),plot([0:length(error2)-1],error2);
