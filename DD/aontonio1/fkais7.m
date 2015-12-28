%% Program for plots of salesnick and maa differentiator\

clc
clear all

format long G
load('F:\Users\JC\Documents\xx.mat')
hf=Expression1;
load('F:\Users\JC\Documents\v.mat')
v=Expression1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=((pi/(R/2))*i)^v;
end

%% fourier series diff plots

gh=max(abs(hf(:)));
loc=find(abs(hf(:))==gh);
    if mod(v,2)==0
    
hf(loc)=hf(loc)-sum(hf(:));
    else

hf(loc(1))=hf(loc(1))-sum(hf(:))/2;
hf(loc(2))=hf(loc(2))-sum(hf(:))/2;
    end


[Hf,wf] = freqz(hf,1,R/2);
ho=abs(Hf)/pi;
figure(1)
plot(wf/pi,ho,'LineWidth',1.2);
hold on
 plot(wf/pi,u/pi)
 grid on
 hold on
%% error plots
for i=1:R/2
    E(i)=u(i)/pi-ho(i);
end
th=find(E*1000/pi>=10);
figure(2)
plot(wf(1:th(1))/pi,E(1:th)*1000/pi,'LineWidth',1.2);xlabel('Frequency (Hz)');ylabel('%age error');
grid on
hold on
% (1:ceil((R/2)*.5768))