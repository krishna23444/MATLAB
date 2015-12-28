clc
clear all
close all
format long G

a=-11:.05:11;
g0=2.*exp(-.2.*a.^2).*((a>=-3)-(a>3));
g1=.5.*exp(1i.*.3.*(a+8.6).^2)+exp(-1i.*3*a).*exp(-.1.*(a-7).^2);
f=g1+g0;


  figure(1)
  qwigner2(g0)  
% contour((stft2(f, 1, 256,1,9, 'short')))

p=fracft(f,-.93);

%   figure(2)
%    qwigner2(p)  
%  contour((stft2(p, 1, 256,1,9, 'short')))
% 
 q1=[zeros(1,210) ones(1,20) zeros(1,211)];
 w=p.*q1';
%  figure(3)
%   qwigner2(w)  
% % contour((stft2(w, 1, 256,1,9, 'short')))
%  
 s=fracft(w,.93);
% figure(4)
%   qwigner2(s)
 
  q2=[zeros(1,159) ones(1,121) zeros(1,161)];
w1=s.*q2';

p2=fracft(f,1);
qwigner2(p2)
q3=[zeros(1,216) ones(1,8) zeros(1,217)];

 w3=p2.*q3';
 
p3=fracft(w3,-1);
figure(10)
qwigner2(p)
q4=[zeros(1,153) ones(1,140) zeros(1,148)];
 w4=p3.*q4';



 figure(7)
 plot(real(f))
figure(6)
plot(real(g0))
hold on
plot(real(w1))
% plot(real(w4))
% 
 
g0=g0';
hh=1:length(f);
 ss1=sum((abs(real(w1(hh))-real(g0(hh)))).^2);
 ss2=sum((abs(real(w4(hh))-real(g0(hh)))).^2);
 ddd=sum(abs(real(g0(hh))).^2);
 ss1/ddd
 ss2/ddd




