clc
clear all
close all


load('D:\MATLAB 2010 Portable\bin\DD\ecgsim1\GoldStandard.mat');
ecg1=signal(1:1100);
load('D:\MATLAB 2010 Portable\bin\DD\ecgsim1\Num.mat');h=Num;

for k=1:length(ecg1)
ec(k)=5*(rand-.5);
end

d=filter(h,1,ec);
e=ecg1+ec;
figure(1)
plot(ecg1);axis([0 1100 -50 100])

load('F:\Users\JC\Documents\xx.mat')
hf=imag(Expression1);

r=filter(hf,1,ecg1);
% rr=filter(hf,1,ecg1);
figure(2)
plot(r);axis([0 1100 -10 10])
