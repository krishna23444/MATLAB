
clc
clear all
f1=input('enter frequency of interest');
N=input('enter sampling frequency');
a=input('enter stopband attenuation');
M=input('enter decimation factor');
tw=N/(M*2)-f1;
dp=input('enter passband ripple');
ds=input('enter stopband ripple');
freqs=input('enter frequencies in input');
B=wndw(f1,a,N,tw,dp,ds);
n=0:N-1;
for i=1:length(freqs)
    X(i,:)=sin(2*pi*n*freqs(i)/N);
end
for i=1:N
    x(i)=sum(X(:,i));
end

y=x(1:M:N);
figure(1)
P=abs(fft(x)/max(fft(x)));
Q=abs(fft(y)/max(fft(y)));
subplot(2,1,1);plot(P(1:N/2));grid; xlabel('Frequency (Hz)');
subplot(2,1,2);plot(Q(1:N/(2*M)));grid; xlabel('Frequency (Hz)');
w=conv(B,x);
w=w(1:N);

e=w(1:M:N);
U=abs(fft(e)/max(fft(e)));
figure(2)
plot(U(1:N/(2*M)));grid; xlabel('Frequency (Hz)');
