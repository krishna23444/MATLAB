clc
clear all
close all

t=-4:.01:4;

x=-t.*exp(-.8.*(t.^2)).*exp(1i.*(1.7.*t.^2+.15.*t.^3)).*sin(1.6.*t)+...
exp(-.4.*(t.^2)).*exp(1i*(2.*t.^2+.1.*t.^3)).*cos(2.*t)+exp(-.5.*(t-.2).^2).*sin(t);

y=frft(x,.5);
for l=1:length(y)
    y1(l)=y(l)*1i*l/100;
end