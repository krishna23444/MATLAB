clc
clear all
close all

% t=0:.01:5;
% x=cos(t*pi);
% q=[zeros(1,length(t)*3/10) ones(1,length(t)*4/10) zeros(1,length(t)*3/10+1)];

a = -11:.1:11
x=exp(((1i.*a.^2)/2)+12.*1i.*a).*exp(-((a-4).^2)./20);

for k=4:-.1:0
 qwigner2(fracft(x,k))
% f1=fracft(q,k);
% contour((stft2(f1, 1, 256,1,7, 'short')))
title(['The values of x are: ', num2str(k)]);
pause(.8)
end