clc
clear all
close all

k=1;
Ord=31;

n=(Ord-1)/2;
grid on
hold on

for i=-n:n
    K=k*i*pi;
h(n+i+1)=(4*K*cos(K)+2*(-2+K^2)*sin(K))/(i^2);
end
h(i+1)=20;

y1=abs(fft(h,6280));
% figure(1)
% plot(y(1:3140)); 




for i=0:3140
    u(i+1)=((pi/3140)*i)^2;
end
     

% for i=1:3140
%     e(i)=y(i)-u(i);
% end
% figure(1)
%  grid on
%  plot(e(1:2500));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
% hold on


alp=5.691562;
for i=-n:n
r(i+n+1)=besseli(0,alp*sqrt(1-(2*i/(Ord-1))^2))/besseli(0,alp);
end
T=h.*r;

y=abs(fft(T,6280));

 figure(1)
 plot(y)
 plot(u)

 
 hold on
 grid on
plot(abs(fft(lowdiff(6,29),6280))/max(abs(fft(lowdiff(6,29),6280))),'r')
 
% for i=1:3140
%     E(i)=y(i)-u(i);
% end
% hold on
% grid on
% figure(2)
% plot(E(1:2000));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
