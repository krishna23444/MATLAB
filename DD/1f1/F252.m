        
clc
clear all
close all
format long G
x=input('enter value ');
del=input('enter error %age');
x1=-x;
Vd=hypergeom(2,5/2,x);

e=1;
N=0;
q=1;
while abs(e(q))>(del/100)*Vd
     q=q+1;
     i=0:N;
     V1=(2/sqrt(pi)).*(sum(((-1).^i).*((1i*sqrt(x1)).^(2.*i+1))./((factorial(i)).*(2.*i+1))));
     V1=-1i*V1;
     V2=sum((x.^i)./factorial(i));
     V1=(V1*V2*(1+2*(x1))*3*sqrt(pi))/(8*(x1^1.5));
     V1=V1-(3/(x1*4));
     e(q)=Vd-V1;
     N=N+1;
end
 e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;