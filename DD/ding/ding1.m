clc
clear all
close all

t=-5:.1:5;

x=-t.*exp(-.8.*(t.^2)).*exp(1i.*(1.7.*t.^2+.15.*t.^3)).*sin(1.6.*t)+...
exp(-.4.*(t.^2)).*exp(1i*(2.*t.^2+.1.*t.^3)).*cos(2.*t)+exp(-.5.*(t-.2).^2).*sin(t);


for k=1:length(x)
  n(k)=(rand-.5)+1i*(rand-.5);
  f(k)=x(k)+n(k);
end
  

x3=dFRT(length(t),-0.2951);
x1=f*x3;
y1=frft(f,-0.2951);
d1=frft2(f,-0.2951);
z1=cdpei(f,-0.2951);
p1=fracft(f,-0.2951);
b1=Disfrft(f,-0.2951);

figure(2)
plot(real(x1))
figure(3)
plot(real(y1))
figure(4)
plot(real(z1))
figure(5)
plot(real(p1))
figure(6)
plot(real(b1))
 
% U=[ones(1,93) zeros(1,15) ones(1,93)];
% x2=fftshift(x1).*U;
% y2=y1.*U';
% z2=z1.*U';
% 
% 
% 
% x3=dFRT(length(t),0.2951);
% x3=x2*x3;
% y3=frft(y2,0.2951);
% z3=cdpei(z2,0.2951);
