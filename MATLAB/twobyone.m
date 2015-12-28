% 2-N point fft calculation using Npoint calc
clc
clear all

x=input('enter the sequence');
N=length(x);

v=1;
for j=1:N/2
    for i=1:2
        y(i,j)=x(v);
        v=v+1;
    end
end

for i=1:N/2;
     b(i)=y(1,i)+sqrt(-1)*y(2,i);
end

q=b*w(N/2);
q(N/2+1)=q(1);

for i=0:N/2-1
    
        xrp(i+1)=(real(q(i+1))+real(q(N/2-i+1)))/2;
        xrn(i+1)=(real(q(i+1))-real(q(N/2-i+1)))/2;
        xip(i+1)=(imag(q(i+1))+imag(q(N/2-i+1)))/2;
        xin(i+1)=(imag(q(i+1))-imag(q(N/2-i+1)))/2;       
        
end

       
        
        
  for i=1:N/2
        Rr(i)=xrp(i)+cos(pi*(i-1)*2/N)*xip(i)-sin(2*pi*(i-1)/N)*xrn(i);
        Ri(i)=xin(i)-sin(pi*(i-1)*2/N)*xip(i)-cos(2*pi*(i-1)/N)*xrn(i);
  end
       
       
      for i=1:N/2
          DFT(i)=Rr(i)+sqrt(-1)*Ri(i);
      end
      
      DFT(1+N/2)=real(DFT(N/2));
      
        
      for i=2:N/2
          DFT(i+N/2)=conj(DFT(N/2-i+2));
      end
      
      sprintf('%2.1f point DFT calculation by using %2.1f point is',N,N/2)
      DFT
          
        
        