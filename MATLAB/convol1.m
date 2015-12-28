clc
clear all

x=input('enter the sequence');
y=input('enter the response');

n=length(x);
m=length(y);

M=max(n,m);

if n>m
    for i=1:n
        x(i+n)=x(i);
        x(i)=0;
    end
end

if m>n
    for i=1:m
        y(i+n)=y(i);
        y(i)=0;
    end
end
