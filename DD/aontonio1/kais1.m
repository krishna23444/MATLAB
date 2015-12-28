clc
clear all

format long G

for Ord=101
b=5.332918
n=(Ord-1)/2
grid on
hold on
for i=-n:n
    h(n+i+1)=cos(i*pi)/i;
end
h(i+1)=0;


y1=abs(fft(h,6280));
% figure(1)
% plot(y(1:3140)); 




for i=0:3139
    u(i+1)=(pi/3140)*i;
end
    

for i=1:3140
    e1(i)=y1(i)-u(i);
end
% figure(2)
% plot(e(1:3000));xlabel('Frequency (Hz)');ylabel('Magnitude Response');





for i=-n:n
r(i+n+1)=I(b*sqrt(1-(2*i/(Ord-1))^2))/I(b);
end
T=h.*r;

y2=abs(fft(T,6280));
hold on
% figure(1)
% plot(y(1:3140))
for i=1:3140
    e2(i)=y2(i)-u(i);
end
figure(1)
plot(e2(1:3000));xlabel('Frequency (Hz)');ylabel('Magnitude Response');
hold on
end