clc
clear all
close all
format long G

a=-5:.05:5;
x= 2.*cos(5.*a).*exp(-a.^2/10);
z = .5.*exp(1i.*.23.*a.^2) + .5.*exp(1i.*.3.*a.^2 + 1i.*8.5.*a) + .5.*exp(1i.*.46.*a.^2 - 1i.*9.6.*a);
f = x + z;


 figure(1)
 qwigner2(x)  
% contour((stft2(f, 1, 256,1,9, 'short')))

p= fracft(f,1);
figure(2)
 qwigner2(p)  
%  contour((stft2(p, 1, 256,1,9, 'short')))

q1=[zeros(1,90) ones(1,4) zeros(1,11) ones(1,5) zeros(1,91)];
w=p.*q1';
% figure(3)
%  qwigner2(w)  
% contour((stft2(w, 1, 256,1,9, 'short')))
 
s=fracft(w,-1);
figure(4)
qwigner2(s)
 
%  q2=[zeros(1,20) ones(1,160) zeros(1,21)];
%  w=s.*q2';
%  figure(5)
%  qwigner2(w)

figure(6)
plot(real(x))
hold on
plot(real(s))
x=x'
hh=1:length(x);
ddd=sum(abs(real(x(hh))).^2)
sss=sum((abs(real(s(hh))-real(x(hh)))).^2)/ddd

