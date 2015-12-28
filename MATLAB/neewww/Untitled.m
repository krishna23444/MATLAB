clc
clear all

x=input('enter the first sequence');
h=input('enter the second sequence');
n=length(x);
m=length(h);

for i=2:(m+n+2)
    j=1:(i-1)
    y(i-1)=sum(x(j).*h(i-j))
    
end
y
    