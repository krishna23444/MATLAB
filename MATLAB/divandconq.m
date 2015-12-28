clc
clear all
 
x=input('enter the sequence');
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
 
 p=k(:).';
 
 disp('The result of DFT by Divide & Conquer Method is :'),disp(p.')
 
 
 
 
 
 
 
 
     



