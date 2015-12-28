clc
clear all
n=input('enter length of bit stream')
for i=1:n
    p(i)=input('Enter sequence')
end
t=1:.01:3;
amp=3
freq_hz1=2;
freq_hz2=3;
x=0;
for i=1:n
if(p(i)==0)
   
   z=amp*sin(2*pi*freq_hz1*t);

elseif(p(i)==1)
   
   z=amp*sin(2*pi*freq_hz2*t);
end
   x=cat(2,x,z)
end

subplot(2,3,1)
plot(x)





    





%