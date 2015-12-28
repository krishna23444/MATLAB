clc
clear all
close all
complete;
load Q

for k=1:length(x)
  n(k)=.5*(rand-.5);
  f(k)=ecg(k)+n(k);
end
figure(1)
plot(f)
figure(2)
plot(conv(f,Q,'valid'))
