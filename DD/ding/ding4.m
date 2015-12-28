clc
clear all

t=-5:.05:5;
s=2.*cos(5.*t).*exp(-t.^2./10);
n=.5.*exp(1i.*.23.*t.^2)+.5.*exp(1i.*.3.*t.^2+1i.*8.5.*t)+.5.*exp(1i.*.46.*t.^2-1i.*9.6.*t);
s1=s+n;
plot(real(s))

x=dFRT(length(t),-0.7256);
x1=s1*x;
d1=frft2(s1,-0.7256);
y1=frft(s1,-0.7256);
z1=cdpei(s1,-0.7256);

U=[ones(1,93) zeros(1,15) ones(1,93)];
d2=d1.*U';
x2=fftshift(x1).*U;
y2=y1.*U';
z2=z1.*U';

figure(2)
plot(real(x2))
figure(3)
plot(real(y2))
figure(4)
plot(real(z2))
figure(5)
plot(real(d2))

x3=dFRT(length(t),0.7256);
x3=x2*x3;
y3=frft(y2,0.7256);
z3=cdpei(z2,0.7256);
d3=frft2(d2,0.7256);

figure(6)
plot(real(x3))
figure(7)
plot(real(y3))
figure(8)
plot(real(z3))
figure(9)
plot(real(d3))

