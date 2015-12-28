clc
% c=circshift(d',[0 -80])
clear all
f=.25;
w=2*pi*f;
n=13;
a=.2;

w1=kaiser(27,3.9754);
 d=frft([w1' zeros(1,473)],a);
 d=circshift(d',[0  -find(abs(d)/max(abs(d))==1)])
  figure(1)
 plot(20*log10(abs(d)/max(abs(d))))
 hold on
d1=frft(w1,a)
 
hold on 
grid on