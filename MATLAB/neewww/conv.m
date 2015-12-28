clc
clear all

x=input('enter the first sequence');
h=input('enter the second sequence');
n=length(x);
m=length(h);


for i=1:n
    x1(i)=x(n-i+1);
end

h=[zeros(1,(n-1)) h]