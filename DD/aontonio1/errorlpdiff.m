clc
clear all
close all

load('F:\Users\JC\Documents\h.mat');
hf=imag(Expression1);
load('F:\Users\JC\Documents\xy.mat');
v=Expression1;
load('F:\Users\JC\Documents\k.mat');
k=Expression1;

R=20000;

for i=0:(R/2)-1
    u(i+1)=((2*pi/R)*i)^v;
end

h=kaiser(length(hf),6.9).*hf;

[cc,vv]=freqz(h,1,[0 .8]);


[Hf,wf] = freqz(h,1,R/2);
Hf1=abs(Hf)-abs(cc(1));
ho=abs(Hf1)
figure(1)
plot(wf/pi,ho,'LineWidth',1.2);
hold on
plot(wf/pi,u,'LineWidth',1.2);
grid on

for i=1:R/2
    E(i)=u(i)-ho(i);
end
th=find(E*1000/pi>=10);
figure(2)
plot(wf(1:th(1))/pi,E(1:th)*1000/pi,'LineWidth',1.2);xlabel('Frequency (Hz)');ylabel('%age error');
grid on