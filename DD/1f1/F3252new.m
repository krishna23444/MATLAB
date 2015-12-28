%      erfi approx
%      V1=(2/sqrt(pi)).*(sum(((-1).^i).*((j*x).^(2.*i+1))./((factorial(i)).*(2.*i+1))))
%      V1=-j*V1

clc
clear all
close all
format long G
% x=input('enter value ');
% del=input('enter error %age');
% x1=-x;
e=[1;1];
N=0;
q=1;
z=1
for phi=pi/4:pi/12:pi/3
u=3;
x1=1i*u^2*csc(2*phi);
Vd=hypergeom(3/2,5/2,-x1);
   
while abs(real(e(z,q)))>(2/100)*abs(real(Vd)) && abs(imag(e(z,q)))>(2/100)*abs(imag(Vd))


     q=q+1;
     i=0:N;
     
     V1=(2/sqrt(pi)).*(sum(((-1).^i).*((1i*sqrt(x1)).^(2.*i+1))./((factorial(i)).*(2.*i+1))));
     V1=(-1i*V1);
     V1=exp(-x1^2)*(1+j*V1);
          V1=(V1*3*sqrt(pi))/(4*x1^(3/2));
   
%      V2=sum((x.^i)./factorial(i));
V2=exp(-x1)
  V2=(3*V2)/(2*x1);
     V1=V1-V2;
     
     [real(e(z,q)) imag(e(z,q))]=[real(Vd-V1) imag(Vd-V1)];
     N=N+1;
end
 z=z+1
end
%  e=(e/Vd)*100;
%  figure(1)
% plot(0:length(e)-2,e(2:length(e)));
% figure(2)
% plot(0:length(e)-2,abs(e(2:length(e))));
% grid on;