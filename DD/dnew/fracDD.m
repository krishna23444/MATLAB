%tseng-electronic letters paper
clc
clear all
close all
format long G
N=10;
to=5;
v=2;
for i=0:N
    for l=0:N
    A(l+1,i+1)=(N+1-i)^l;
    end
    b(i+1)=gamma(i+1)*(N+1-to)^(i-v)/gamma(i+1-v);
end
h=inv(A)*b.';
[f,d]=freqz(h,1,linspace(0,pi,3141));
a=[linspace(0,pi,3141)].^v;
% a=a./(10^6);
plot((1:3141)/1000,a);
hold on
plot((1:3141)/1000,abs(f));
grid on


