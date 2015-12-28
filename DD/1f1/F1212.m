
% exponential approx
% i=0:N;
% V=sum((x.^i)./factorial(i));

clc
clear all
close all
format long G
x=input('enter value of x');
Vd=exp(x);
e=1;
N=0;
q=1;
while abs(e(q))>.02*Vd

     q=q+1;
     i=0:N;
     V=sum((x.^i)./factorial(i));
     e(q)=Vd-V;
     N=N+1;
end
e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;
    