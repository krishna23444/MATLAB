clc
clear all

format long G
N=10;
to=5;
v=1.5;
for k=0:N
    for p=1:N+1
    A(p,k+1)=cos(p*(N+1-k));
    
    b(p)=(p^v)*cos(p*(N+1-to)+(pi*v/2));
    end
end
h=inv(A)*b.';

[f,d]=freqz(h,1,linspace(0,pi,3141));
% a=[linspace(0,pi,3141)].^v;
% a=a./(10^6);
% plot((1:3141)/1000,a);
% hold on
 plot((1:3141)/1000,abs(f));
grid on


