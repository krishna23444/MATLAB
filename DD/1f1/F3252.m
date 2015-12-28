clc
clear all
close all
format long G
x=input('enter value ');
del=input('enter error %age');
x1=-x;
Vd=hypergeom(3/2,5/2,x);

e=1;
N=0;
q=1;
while abs(e(q))>(del/100)*Vd
N=N+1;
     q=q+1;
     i=0:N;
     V1=(2/sqrt(pi)).*(sum(((-1).^i).*(sqrt(x1).^(2.*i+1))./((factorial(i)).*(2.*i+1))));
     V1=(V1*3*sqrt(pi))/(4*x1^(3/2));
     V2=sum((x.^i)./factorial(i));
     V2=(3*V2)/(2*x1);
     V=V1-V2;
     e(q)=Vd-V;
end
e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;