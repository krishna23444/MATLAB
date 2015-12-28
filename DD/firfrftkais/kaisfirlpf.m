clc
clear all


b=3.9754;
N=27;
n=(N-1)/2;
f=.25;
w=2*pi*f;


for i=-n:n
    hd(i+n+1)=2*f*sin(w*i)/(w*i);

end
    hd(n+1)=2*f;

H=fft(hd);

    for i= -n:n
    
                     w(i+n+1)=besseli(0,b*sqrt(1-(2*i/(N-1))^2))/besseli(0,b);

    end

for a=0:.1:1

y=Disfrft(w,a);

s=cconv(y',H,500);
plot(20*log10(abs(s)/max(abs(s))));
grid on
hold on
end