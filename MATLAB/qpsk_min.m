clear all;          
clc;

  %generate random signals%
N=50000;

  % input('enter the no. of bits to be defined');
a=randsrc (1,N,[0,1]);

  %modulation
odd = a(1:2:end);
even = a(2:2:end);
for i=1:N/2
    if [odd(i) even(i)]==[0 0]
         b(i)=-1-j;
             end
     if[odd(i) even(i)] ==[0 1]
         b(i)=-1+j;
     end
     if [odd(i) even(i)]==[1 0]
         b(i)=1-j;
     end
if [odd(i) even(i)]==[1 1]
        b(i)=1+j;
end
   end


%         %noise
   for SNR_dB=-3:10
    n=SNR_dB+4;
       c=awgn(b,SNR_dB);
   
   
    
%    data = zeros(1,N);
%        %demodulation
%        
%        for v= 1:N
%            
%       if c(v) == (0/1)
%           data(v) = (atand(c(v))== [0 0]) ;
%           if c(v) == (1/0)
%               data(v) = (atand(c(v)) == [0 1]);
%               if c(v)== (-1/0)
%                   data(v) = (atand(c(v)) == [1 0]);
%               else
%                   data (v) = (atand(c(v))== [1 1]);
%               end
%           end
%       end
%        end
%       
%            
%    
%    
%               
%           
% 
%  %count error bits
%    
%  B = a - data;
%     BER(n) = length(find(B)) / N;
%     end
%   
% SNR_dB=-3:10
%    semilogy(SNR_dB,BER,'Color','k','Linewidth',2);
%   axis([-3 10 10^-5 0.5])
%  xlabel('SNR, dB');
%  ylabel('BER');
% %  title('Error Probability (BPSK)');

%demodulation
for i=1:N/2
    realc=real(c(i));
    imagc=imag(c(i));
    angl(i)=atan2(imagc,realc);
    angl(i)=angl(i)*180/pi;
end

      
for i=1:N/2
    if angl(i)<-90 && angl(i)>-180
       eveno(i)=0; 
       oddo(i)=0;
    end
        if angl(i)<0 && angl(i)>-90
            eveno(i)=0; 
            oddo(i)=1;
        end
            if angl(i)>0 && angl(i)<90
            eveno(i)=1;
            oddo(i)=1;
            end
            if angl(i)>90 && angl(i)<180
                eveno(i)=1;
                oddo(i)=0;
            end
end
 p=1;       
for i=1:N/2
    rx(p)=oddo(i);
    p=p+1;
    rx(p)=eveno(i);
    p=p+1;
end
 %count error bits
   
    B = a - rx;
    BER(n) = length(find(B)) / N;
    end
   
  semilogy(1:14,BER);
  xlabel('SNR(dB)');
  ylabel('BER');
  grid on;