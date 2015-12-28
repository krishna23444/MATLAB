
% exponential approx
% i=0:N;
% V=sum((x.^i)./factorial(i));

clc
clear all
close all
format long G
% x=input('enter value of x');
 del=2
%  input('enter error %age');
u=3;
phi=pi/3;
x=-j*u^2*csc(2*phi);
P=real(x);
Q=imag(x);
Vd=exp(x);
e=1+j
N=0
q=1
     X=real(e(q));
     Y=imag(e(q));

while abs(real(e(q)))>(del/100)*abs(real(Vd)) && abs(imag(e(q)))>(del/100)*abs(imag(Vd))
    
     q=q+1
     i=0:N
     V=sum((P.^i)./factorial(i))
     V=V*(cos(Q)+j*sin(Q))
     
%      U=real(V)
%      O=imag(V)
%       if sign(U) == -1
%          U=-U
%            
%      elseif sign(O) == -1
%          O=-O
%          
%      end
%      e(q)=Vd-(U+j*O)
%      X=real(e(q))
%      Y=imag(e(q))
%      if sign(X) == -1
%          X=-X
%      elseif sign(Y) == -1
%          Y=-Y
%      end
e(q)=Vd-V
     N=N+1
end
e=(e/Vd)*100;
%  figure(1)
% plot(0:length(e)-2,e(2:length(e)));
% figure(2)
plot(0:length(e)-2,abs(e(2:length(e))));
grid on;
    