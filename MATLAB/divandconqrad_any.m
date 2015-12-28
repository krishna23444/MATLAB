clc
clear all
 
x=input('enter the sequence');
M=input('enter the Radix');

N1=length(x);
H=M^(ceil(log2(N1)/log2(M)))-N1;
x=[x,zeros(1,H)];
N=length(x);
 
L=N/M;

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
 
 DFT=reshape(k,1,N);
 
 sprintf('The result of DFT by Divide & Conquer(Radix %2.1f) Method is :',M)
 DFT
 
 
 
 
 
 
 
 
     



