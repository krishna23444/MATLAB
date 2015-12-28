clc
clear all
for i=1:8
    p(i)=input('Enter bit stream')
end
t=1:0.01:2;
freq_hz=2;
freq_rps=2*pi*freq_hz;
amp1=2;
amp2=3;
amp3=5;
amp4=4;
x1=amp1*sin(freq_rps*t);
x2=amp2*sin(freq_rps*t+(pi/2));
x3=amp3*sin(freq_rps*t+pi);
x4=amp4*sin(freq_rps*t+(3*pi/2));
y=0;
for i=1:2:8
    if((i+1)<=8)
    if(p(i)==0&&p(i+1)==0)
        x=x1;
    elseif(p(i)==0&&p(i+1)==1)
        x=x2;
    elseif(p(i)==1&&p(i+1)==0)
        x=x3;
    else
        x=x4;
    end
       
        y=cat(2,y,x);
    end
end
subplot(2,3,2)
plot(p)
subplot(2,3,5)
plot(y)