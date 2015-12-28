
% exponential approx
% i=0:N;
% V=sum((x.^i)./factorial(i));

clc
clear all
close all
format long G
syms x
f=exp(x);

x1=input('enter value of x');    
Vd=exp(x1);
e=1;
N=1;
q=1;
while abs(e(q))>.02*Vd
     t=taylor(f,N);
     x=x1
     t1=subs(t)
     q=q+1;
     
     e(q)=Vd-t1;
     N=N+1;
end
e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;
