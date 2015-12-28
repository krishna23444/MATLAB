clc
clear all
close all
format long G
N=10;
to=6;
v=1.5;
for i=0:N
    for l=0:N
    A(l+1,i+1)=(N+1-i)^l;
    end
    b(i+1)=gamma(i+1)*(N+1-to)^(i-v)/gamma(i+1-v);
end
h=fft(b,1000)/fft(A,1000)
[f,d]=freqz(h,1,linspace(0,pi,3141));
a=[linspace(0,pi,3141)].^v;
% a=a./(10^6);
plot((1:3141)/1000,a);
hold on
plot((1:3141)/1000,abs(f));
grid on


