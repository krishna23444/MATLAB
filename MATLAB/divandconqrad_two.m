clc
clear all
 
x=input('enter the sequence');

N1=length(x);
H=2^(ceil(log2(N1)))-N1;
x=[x,zeros(1,H)];
N=length(x);
 
F=factor(N);
L=max(F);
M=N/L;

v=1;
for j=1:M
    for i=1:L    
         y(j,i)=x(v);
         v=v+1;
    end
end

 for i=1:L
     b(:,i) =w([M])*y(:,i);
 end
 
 o= w([N]);
 
 for i=1:M
     for f=1:L
       g(i,f) = o(i,f)*b(i,f);
     end
 end
 
 for i=1:M
     k(i,:) =g(i,:)*w([L]);
 end
 
 p=reshape(k,1,N);
 
 disp('The result of DFT by Divide & Conquer(Radix 2) Method is :'),disp(p)
 
 
 
 
 
 
 
 
     



