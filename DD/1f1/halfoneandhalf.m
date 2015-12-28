clc
clear all
close all
format long G

x1=input('enter value of x');
x=sqrt(x1);
Vd=hypergeom(1/2,3/2,x);
N=5
n=11;
for i=1:n
       O(i)=-(2*(i-1)+1);
       O(1)=1;
       
end

for i=1:N
    C=cumprod(O(1:i))
    h=0;
    for l=1:i
        C(l)=C(l)/x^(h)
        h=h+2
    end
    S=(((1-(sum(C)/(x^2)))*exp((-x^2)/2))/(sqrt(2*pi)*x))*(.5*sqrt(pi/x))
    
    
   e(i)=Vd-S
 end

       
    