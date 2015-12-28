clc
clear all


b=3.9754;
N=27
n=(N-1)/2;
f=.25;
w=2*pi*f;
a=1;

for i=-n:n
    hd(i+n+1)=2*f*sin(w*i)/(w*i);

end
    hd(n+1)=2*f;
%  H=cdpei([hd zeros(1,24)],a);
 H1=fft(hd,51);
% H=[ones(1,250) zeros(1,500) ones(1,250)];

%      for i= -n:n
     
%       w(i+n+1)=besseli(0,b*sqrt(1-(2*i/(N-1))^2))/besseli(0,b);    
%      end
w = kaiser(27,b)';
% w=triang(27)
% y=fft(w,500);

 y=cdpei([w zeros(1,24)],a);
% y1=fft(y);
% s=ifft(H1.*y1)
 s=cconv(y',H1,51);
 
s=ifft(s);

d=fft(s,500);
 d=circshift(d,[0 ceil((1-a)*200)])
% s=fft(w1'.*hd,10000);
plot(20*log10(abs(d)/max(abs(d))));
grid on
hold on