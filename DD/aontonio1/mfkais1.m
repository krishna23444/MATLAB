clc
clear all
close all
format long G
load('F:\Users\JC\Documents\xx.mat')
hf=Expression1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=(2/R)*i;
end

[Hf,wf] = freqz(hf,1,R/2);
% ho=abs(Hf)/max(abs(Hf))
ho=abs(Hf)*.5/abs(Hf(5000));

 plot(wf/pi,ho,'LineWidth',1.2);
hold on
grid on
plot(wf/pi,u,'r','LineWidth',1.2)

for i=1:R/2
    E(i)=u(i)-ho(i);
end
figure(2)
plot(wf/pi,E*1000/pi,'k','LineWidth',1.2);xlabel('Frequency (Hz)');ylabel('%age error');
