clc
clear all
N=50000;
r=randerr(1,N,N/2);

t=2*r-1;
snr=-5:20;
noi=randn(1,N);

for SNR=1:length(snr)
    a=t+10^(-snr(SNR)/20)*noi;
        
    
 
     for i=1:N
        if a(i)>0
            b(i)=1;
        else
            b(i)=0;
        end
     end
ber=0;
     for k=1:N
         if b(k)~=r(k)
             ber=ber+1;
         end
     end
   B(SNR)=ber/50000;
end
semilogy(1:length(snr),B);grid;





