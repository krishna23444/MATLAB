clc
clear all
close all
load('F:\Users\JC\Documents\xx.mat')
hf=Expression1;
a=-11:.1:11;
h0=-a.*exp(-.8.*(a.^2)).*exp(1i.*(1.7.*a.^2+.15.*a.^3)).*sin(1.6.*a)+...
exp(-.4.*(a.^2)).*exp(1i*(2.*a.^2+.1.*a.^3)).*cos(2.*a)+exp(-.5.*(a-.2).^2).*sin(a);
% z = exp(((1i.*a.^2)/10)-3.*1i*a).*((a>=-9)-(a>1));
z=exp(((1i.*a.^2)/2)+.5.*1i.*a).*exp(-((a-7).^2)./20);
h1=h0+z

 figure(1)
 qwigner2(fracft(h0,3.2))  


 
s=fracft(h1,3.2);
d=conv(s,imag(hf))
plot(abs(d))
figure(2)
contour(abs(stft2(d, 1, 256,1,7, 'long')),0.05:.01:2)

