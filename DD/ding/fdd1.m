clc
clear all
t=-4:.005:4;
x=-t.*exp(-.8.*(t.^2)).*exp(1i.*(1.7.*t.^2+.15.*t.^3)).*sin(1.6.*t)+...
exp(-.4.*(t.^2)).*exp(1i*(2.*t.^2+.1.*t.^3)).*cos(2.*t)+exp(-.5.*(t-.2).^2).*sin(t);
for k=1:length(x)
  n(k)=(rand-.5)+1i*(rand-.5);
  f(k)=x(k)+n(k);
end
al=pi/4;
a=al*2/pi;
df=dFRT(length(t),a);
g1=x*df;
g2=fft(g1);
g3=g1+g2;
g3=g3/sqrt(2);
for k=1:length(t)
g4(k)=1i*g3(k)*k/100;
end
rdf=dFRT(length(t),-a);
g5=g4*rdf;
plot(abs(g5))