clc
clear all
close all
k=.57;
Ord=29;

n=(Ord-1)/2
grid on
hold on
R=6280;
for i=-n:n
h(n+i+1)=(2*k*i*pi*cos(k*i*pi)-2*sin(k*i*pi))/(i^2);
end
h(i+1)=0;

y1=abs(fft(h,6280));
% figure(1)
% plot(y(1:3140)); 




for i=0:3140
    u(i+1)=(pi/3140)*i;
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
h2=h.*r;

K = 7;  L = 10;   %  length(h) = K+2L+2
h1 = lowdiff(K,L);
[H1,w1] = freqz(h1,1,R/2);
plot(abs(H1),'r');
hold on
grid on
[H2,w2] = freqz(h2,1,R/2);
H2=(1/H2(1000))*H2;
plot(abs(H2));
hold on
plot(u)
 
% for i=1:3140
%     E(i)=y(i)-u(i);
% end
% hold on
% grid on
% figure(2)
% plot(E(1:2000));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
