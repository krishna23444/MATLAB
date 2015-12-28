clc
clear all
close all
N=input('Enter the no. of bits to transmit')
x=randerr(1,N,N/2) ;
snr=-5:10
ts=4;%Symbol period
cost=cos(pi*[-ts:N*ts-1]/(2*ts)); 
sint=sin(pi*[-ts:N*ts-1]/(2*ts));

%BPSK modulation
for i=1:N
    if(x(i)==0)
        mod(i)=-1;
    else
        mod(i)=1;
    end
end

b=ones(2*ts,1);

%Sending even and odd bits over 2*ts symbol period
modev=mod(1:2:length(mod));
modod=mod(2:2:length(mod));
ev_tx=reshape(b*modev,1,length(modev)*length(b));
odd_tx=reshape(b*modod,1,length(modod)*length(b));
ev_tx=[ev_tx zeros(1,ts)];
odd_tx=[zeros(1,ts) odd_tx]; %delaying odd samples by period ts
xt = 1/sqrt(ts)*[ev_tx.*cost + j*odd_tx.*sint];
rch=sqrt(-log(randn(1,N*ts+ts)));
noi=randn(1,N*ts+ts);

for sn=1:length(snr)
err=0;
yt = xt.*rch + 10^(-snr(sn)/20)*noi;
yt = yt./rch;
%Integrating even and odd samples on 0 to 2*ts
evrec=conv(real(yt).*cost,ones(1,2*ts)); 
odrec=conv(imag(yt).*sint,ones(1,2*ts));

%Recovering even and odd bits with hard decision decoding
oprec=zeros(1,N);
oprec(1:2:length(oprec))=evrec(2*ts+1:2*ts:end-2*ts)>0;
oprec(2:2:length(oprec))=odrec(3*ts+1:2*ts:end-ts)>0;

%Finding error 
chk_eq=oprec==x;
n_err=sum(chk_eq==0);
ber(sn)=n_err/N;
end
semilogy(snr,ber,'Linewidth',2)
xlabel('Signal To Noise Ratio(SNR)')
ylabel('Bit Error Rate(BER)')
title('BER vs SNR plot for MSK modulation with Rayleigh Fading Channel')
grid on