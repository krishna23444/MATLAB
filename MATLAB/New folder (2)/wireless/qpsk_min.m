clear all;          
clc;

  %generate random signals%
N=5000;

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
snr=-5:10
noi=randn(1,N/2);
rch=sqrt(-log(noi));
   for SNR_dB=1:length(snr)
       
    
  
 c=rch.*b+10^(-snr(SNR_dB)/20)*noi;
        
    
    c=c./rch;  
       if SNR_dB==10
     for i=1:10
         hold on
         figure(1)
         grid on
         legend('received')
     plot(real(c(i)),imag(c(i)),'gh')
     
     
     end
     
     
         figure(1)
         
     plot(real(j),imag(j),'rs')
     plot(real(-1),imag(-1),'rs')
     plot(real(1),imag(1),'rs')
     plot(real(-j),imag(-j),'rs')
     
     
     
     
     hold off
     title('constellation diagram');
       end
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
    BER(SNR_dB) = length(find(B)) / N;
   end
   
      semilogy(1:length(snr),BER);
  xlabel('SNR(dB)');
  ylabel('BER');
  grid on;