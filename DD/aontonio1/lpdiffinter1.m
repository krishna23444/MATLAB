clc
clear all
close all

load('F:\Users\JC\Documents\xx.mat')
gh=Expression1

R=6280;v=1.5
loc=find(gh(:)==max(gh))
gh(loc)=gh(loc)-(sum(gh))
[bn,nb]=freqz(real(gh),1,R/2)
plot(abs(bn))
hold on

for k=0:R/2
    u(k+1)=((pi/(R/2))*k)^v;
end
plot(u)