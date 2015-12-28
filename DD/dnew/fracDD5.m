clc
clear all
close all
format long G
N=10;
to=5;
v=2;
for k=0:N
    for p=0:N
    A(p+1,k+1)=exp(1i*(p+1)*(N+1-k));
    end
    b(k+1)=((1i*(k+1))^v)*exp(1i*(k+1)*(N+1-to));
end
h=inv(real(A))*real(b)';
[f,d]=freqz(h,1,linspace(0,pi,3141));
a=[linspace(0,pi,3141)].^v;
% a=a./(10^6);
% plot((1:3141)/1000,a);
% hold on
plot((1:3141)/1000,abs(f));
grid on


