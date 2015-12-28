clc
clear all
N=5000;
r=randint(1,N,2);
k=1;
for i=1:2:N
    if r(i)==0&&r(i+1)==0
    t(k)=-1;
    k=k+1;
    elseif r(i)==0&&r(i+1)==1
        t(k)=j;
        k=k+1;
    elseif r(i)==1&&r(i+1)==0    
        t(k)=1;
        k=k+1;
    elseif r(i)==1&&r(i+1)==1    
        
        t(k)=-j;
        k=k+1;
    end

end


for snr=1:10
     a=awgn(t,snr);
     if snr==10
     for i=1:100
         hold on
         figure(1)
         grid on
         legend('received')
     plot(real(a(i)),imag(a(i)),'gh')
     
     
     end
     
     
         figure(1)
         
     plot(real(j),imag(j),'rs')
     plot(real(-1),imag(-1),'rs')
     plot(real(1),imag(1),'rs')
     plot(real(-j),imag(-j),'rs')
     
     
     
     
     hold off
     title('constellation diagram');
     
     end
     k=1;
     for i=1:length(a)
        if dist(a(i),(-1))<dist(a(i),(-j))&&dist(a(i),(-1))<dist(a(i),(1))&&dist(a(i),(-1))<dist(a(i),(j))
            b(k)=0;
            b(k+1)=0;
            k=k+2;
        elseif dist(a(i),(-j))<dist(a(i),(j))&&dist(a(i),(-j))<dist(a(i),(1))&&dist(a(i),(-j))<dist(a(i),(-1))
            
            b(k)=1;
            b(k+1)=1;
            k=k+2;
        elseif dist(a(i),(1))<dist(a(i),(-j))&&dist(a(i),(1))<dist(a(i),(-1))&&dist(a(i),(1))<dist(a(i),(j))    
             b(k)=1;
            b(k+1)=0;
            k=k+2;
        elseif dist(a(i),(j))<dist(a(i),(-j))&&dist(a(i),(j))<dist(a(i),(1))&&dist(a(i),(j))<dist(a(i),(-1))
            
            b(k)=0;
            b(k+1)=1;
            k=k+2;
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
 grid on;
  




