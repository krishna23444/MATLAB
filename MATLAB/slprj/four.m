clc
clear all
w=0:.0625:3.9375
X=fftshift(fft(1:16,64))
plot(w,abs(X))
hold on
plot(w,angle(X),'*r')
grid
hold off