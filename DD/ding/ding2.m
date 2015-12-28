clc
clear all
close all

t=-5:.01:5;

x=2.*cos(5.*t).*exp(-t.^2./10);
noise=.5.*exp(1i.*.23.*t.^2)+.5.*exp(1i.*.3.*t.^2+1i.*8.5.*t)+.5.*exp(1i.*.46.*t.^2-1i.*9.6.*t);
f=x+noise;
N=pi*10000;

for n=1:length(f)
    for n=1:length(f)
        for k=-K:K
            G(n,m)=exp(-j*2*pi*m*k/N)*f((n+k)*.01)
  


