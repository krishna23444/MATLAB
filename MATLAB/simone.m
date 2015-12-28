clc
clear all

x=input('enter the sequence');
M=input('enter the radix');

N1=length(x);
H=M^(ceil(log2(N1)/log2(M)))-N1;

x=[x,zeros(1,H)];
N=length(x);
n = log2(N)/log2(M)
L=N/M

v=1;
for j=1:M
    for i=1:L
        y(i,j)=x(v);
        v=v+1;
    end
end

for i=1:L
    y(i,:)=y(i,:)*w(M);
end
 o=w(N);
 
for i=1:L
     for f=1:M
       y(i,f) = o(i,f)*y(i,f);
     end
end

 
while length(y(:,1).')~=M^2
    
    
    
    
    
end




% for k=1:n-3
%        L=L/M  
%         for u=0:M-1
%          t=y(:,u+1,k)   ;
%              v=1;
%              for j=1:L
%                   for i=1:M    
%                       y(j+L*u,i,k+1)=t(v);
%                       v=v+1;
%           end
%         end
%      end
% end
    y
