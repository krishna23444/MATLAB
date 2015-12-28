clc
clear all
N=50000;
r=randint(1,N,2);

for i=1:N
    if r(i)==0
    t(i)=-1+0*j;
    else
        t(i)=1+0*j;
    end

end


for snr=1:10
         a=awgn(t,snr);
    if snr==10
     
     
     for i=1:100
         hold on
         figure(1)
         grid on
     plot(real(a(i)),imag(a(i)),'gh')
     
     end
     
         figure(1)
     hold on
     grid on
     plot(real(1),imag(1),'rs')
     plot(real(-1),imag(-1),'rs')
     title('constellation diagram')
     hold off
     end

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

figure(2)
  semilogy(1:10,B);
  xlabel('SNR(dB)');
  ylabel('BER');
  grid on;
  




