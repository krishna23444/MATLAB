clc
clear all
N=50000;
r=randint(1,N,2);

t=2*r-1;

for snr=1:100
    a=awgn(t,snr);    
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
   B(snr)=ber/10000;
end
semilogy(1:100,B);grid;