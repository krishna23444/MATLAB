clc
% d=circshift(d',[0  -find(abs(d)/max(abs(d))==1)])

clear all
close all
f=.25;
w=2*pi*f;
n=17;
for a=1

w1=hamming(35);
d=frft([w1.' zeros(1,465)],a);

 d=circshift(d.',[0  -find(abs(d)/max(abs(d))==1)])
%  d=circshift(d',[0 -20]) 
%   figure(1)
%  plot(20*log10(real(d)/max(real(d))))
%  hold on

load('F:\Users\JC\Documents\xx.mat')
hd=Expression1;
 
   H=fft(hd,500);
%  H=[ones(1,125) zeros(1,250) ones(1,125)]
   g=d.*H.'
 
%    g=cconv(d,H,500)
%  g=frft([h' zeros(1,200)],a);
g1=ifft(g)
g2=fft(g1,499)
figure(1)
hold on
plot(abs(g2))
% plot(20*log10(abs(g2)/max(abs(g2))))
grid on
end