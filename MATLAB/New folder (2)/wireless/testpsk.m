clc
clear all
n=input('Enter length of sequence')
for i=1:n
    p(i)=input('Enter Sequence');
end
t=1:0.01:2;
freq_hz=2;
freq_rps=2*pi*freq_hz;
amp=2;
x1=amp*sin(freq_rps*t);
x2=amp*sin(freq_rps*t+pi);
x=0;



for i=1:n
    if(p(i)==0)
         b=x1;
    else
         b=x2;
    end
    x=cat(2,x,b);
   
end

subplot(2,3,2)
plot(p)
subplot(2,3,5)
plot(x)
