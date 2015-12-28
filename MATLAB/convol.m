clc
clear all

x=input('enter the sequence');
h=input('enter the response');
N=length(x);
M=length(h);

for i=1:N
    x1(max(N,M)+i-1)=x(i);
end

h=flipud(h.').'

h=[h zeros(1,N-1)];
for j=1:N+M-1
    v=1;
    H(j)=sum(h.*x1);
    h=(circshift(h.',v)).';
    v=v+1;
end
H






