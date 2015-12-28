clc
clear all
close all

a=1;
al=a*pi/2;
u1=8;
u=-10:.05:10;
x = chirp(u,2,2,10);

for k=1:length(x)
  n(k)=(rand-.5)+1i*(rand-.5);
  f(k)=x(k)+n(k);
end
h1=exp(-1i.*cot(al).*u.^2./2).*((u>=-u1)-(u>u1));
h2=fracft(h1,-a);


% g=conv(f,real(h2(100:300)),'valid')
plot(real(h1));


