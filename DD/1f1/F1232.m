%      erf approx
%      i=0:N;
%      V=(2/sqrt(pi)).*(sum(((-1).^i).*(x.^(2.*i+1))./((factorial(i)).*(2.*i+1))))


clc
clear all
close all
format long G
x=input('enter value ');
del=input('enter error %age');
 x1=-x;
Vd=hypergeom(1/2,3/2,x);

e=1;
N=0;
q=1;
while abs(e(q))>(del/100)*Vd

     q=q+1;
     i=0:N;
     V=(2/sqrt(pi)).*(sum(((-1).^i).*(sqrt(x1).^(2.*i+1))./((factorial(i)).*(2.*i+1))));
     V=V*sqrt(pi/x1)*.5;
     e(q)=Vd-V;
     N=N+1;
end
 e=(e/Vd)*100;
 figure(1)
plot(0:length(e)-2,e(2:length(e)));
figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;     