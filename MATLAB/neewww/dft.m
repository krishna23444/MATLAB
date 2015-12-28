clc
clear all

x=input('enter the sequence');
N=length(x);

i=1:N;
for j=1:N
    y(j)=sum(x(i).*twid((i-1),(j-1),N));
end

j=1:N
for i=1:N
    x(i)=sum(y(j).*twid(-(i-1),(j-1),N))/N;
end
