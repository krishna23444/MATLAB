clc
clear all
close all
a=1;
alp=5.691562;
k=.7;
Ord=21;

n=(Ord-1)/2;
grid on
hold on

for i=-n:n
h(n+i+1)=(2*k*i*pi*cos(k*i*pi)-2*sin(k*i*pi))/(i^2);
end
h(i+1)=0;

y=fracft([h zeros(1,478)],1);
% figure(1)
% plot(y(1:3140)); 




for i=0:3140
    u(i+1)=(pi/3140)*i;
end
%     
% 
% for i=1:3140
%     e(i)=y(i)-u(i);
% end
% figure(1)
%  grid on
%  plot(e(1:2500));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
% hold on


for i=-n:n
r(i+n+1)=besseli(0,alp*sqrt(1-(2*i/(Ord-1))^2))/besseli(0,alp);
end
d=fracft([r zeros(1,478)],a);
T=cconv(y,d);

y1=fracft(T,-1);
y=abs(fft(T,6280));
hold on
grid on
 figure(1)
 plot(y/max(y))
% for i=1:3140
%     E(i)=y(i)-u(i);
% end
% hold on
% grid on
% figure(2)
% plot(E(1:2000));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
