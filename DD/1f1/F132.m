%      erfi approx
%      V1=(2/sqrt(pi)).*(sum(((-1).^i).*((j*x).^(2.*i+1))./((factorial(i)).*(2.*i+1))))
%      V1=-j*V1

clc
clear all
close all
format long G
x=input('enter value ');
del=input('enter error %age');
x1=-x;
Vd=hypergeom(1,3/2,-3);
e=1;
N=0;
q=1;
while abs(e(q))>(del/100)*Vd

     q=q+1;
     i=0:N;
     V1=(2/sqrt(pi)).*(sum(((-1).^i).*((1i*sqrt(x1)).^(2.*i+1))./((factorial(i)).*(2.*i+1))));
     V1=-1i*V1;
     V2=sum((x.^i)./factorial(i));
     
     V1=V1*V2;
     V1=V1*.5*sqrt(pi/(x1));
     e(q)=Vd-V1;
     N=N+1;
end
 e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;