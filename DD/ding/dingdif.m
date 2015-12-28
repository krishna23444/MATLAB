clc
clear all
close all
z=.01;
t = -2:z:2;
x = sin(pi*t);
load Q
a=.5;
al=a*(pi/2);

y=fracft(x,a);

for k=1:length(t)
y1(k)=y(k)*1i*(k-100)/(z);
end

y1=y1*sin(al);
% y1=circshift(y1,[0 -10]);
  h=conv(y,Q);
% Y=fft(y);q=fft(Q,length(t));h=ifft(Y.*q');

y2=cos(al)*h(10:410)';
y1=y1*(y2(79)/y1(79));
ye=-y1+y2;

yes=fracft(ye,-a);
figure(1)
plot(real(yes))
figure(2)
plot(real(y1),'r')
hold on
plot(real(y2),'b')



