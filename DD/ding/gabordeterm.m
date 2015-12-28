clc
clear all
close all

% t=0:.01:5;
% x=cos(t*pi);
% q=[zeros(1,length(t)*3/10) ones(1,length(t)*4/10) zeros(1,length(t)*3/10+1)];
a=-11:.1:11;
h0=-a.*exp(-.8.*(a.^2)).*exp(1i.*(1.7.*a.^2+.15.*a.^3)).*sin(1.6.*a)+...
exp(-.4.*(a.^2)).*exp(1i*(2.*a.^2+.1.*a.^3)).*cos(2.*a)+exp(-.5.*(a-.2).^2).*sin(a);
% z = exp(((1i.*a.^2)/10)-3.*1i*a).*((a>=-9)-(a>1));
z=exp(((1i.*a.^2)/2)+.5.*1i.*a).*exp(-((a-7).^2)./20);
h1=h0+z

for k=4:-.1:0
contour(abs(stft2(fracft(h1,k), 1, 256,1,7, 'long')),[0.05:.01:1])
% f1=fracft(q,k);
% contour((stft2(f1, 1, 256,1,7, 'short')))
title(['The values of x are: ', num2str(k)]);
pause(.8)
end