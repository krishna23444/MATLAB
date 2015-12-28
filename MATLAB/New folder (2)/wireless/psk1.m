clc
clear all
N=50000;
r=randerr(1,N,N/2);

for i=1:N
    if r(i)==0
    t(i)=-1+0*j;
    else
        t(i)=1+0*j;
    end

end
 
noi=randn(1,N);

sn=-5:10
for snr=1:length(sn)
     
        a=t+10^(-sn(snr)/20)*noi;
    if snr==16
     
     
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

     
   B(snr)=(length(find(r-b)))/10000;

  
end

figure(2)
  semilogy(-5:10,B);
  xlabel('SNR(dB)');
  ylabel('BER');
  grid on;
 