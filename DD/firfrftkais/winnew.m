clc
clear all
close all

b=3.9754;
N=27;
n=(N-1)/2;
f=.25;
w=2*pi*f;
a=1;

for i=-n:n
    hd(i+n+1)=2*f*sin(w*i)/(w*i);

end
    hd(n+1)=2*f;
% H=fft(hd,1000);
% H=[ones(1,250) zeros(1,500) ones(1,250)];

    for i= -n:n
    
                     w(i+n+1)=besseli(0,b*sqrt(1-(2*i/(N-1))^2))/besseli(0,b);
    
    end

% y=fft(w,1000);

w1=Disfrft(w,a);
% s=cconv(abs(y),abs(H),1000);
% s=ifft(s);
s=fft(w1'.*hd,10000);
plot(20*log10(abs(s)));
grid on
