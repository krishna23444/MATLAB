clear all
clc

N=input('enter the no of points for window');
b=input('enter the value B');
N1=ceil(N/2);
F=input('enter the sampling frequency');

if N/2==N1
      N=N+1;    
      n=((N-1)/2)

for i= -n:n
    r(i+n+1)=besseli(0,b*sqrt(1-(2*i/(N-1))^2))/besseli(0,b);
end
u=linspace(-n,n,2*n+1)
subplot(2,1,2),plot(u,r,'r'),title('window function'),grid on;
r1=fft(r,F);
r2=20*log10(abs(r1/max(r1)));
subplot(2,1,1),plot(r2,'r'),ylabel('Magnitude Response(dB)'),xlabel('frequency');

grid on;

else
n=((N-1)/2)
for i= -n:n
    r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
end
u=linspace(-n,n,2*n+1);
subplot(2,1,2),plot(u,r,'b'),title('window function'),grid on;
r1=fft(r,F);
r2=20*log10(abs(r1/max(r1)));
subplot(2,1,1),plot(r2,'b'),ylabel('Magnitude Response(dB)'),xlabel('frequency')

grid on
end   