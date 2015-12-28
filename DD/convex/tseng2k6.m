clc
close all
% clear all

%% Polynomial example
n=1:1:200;
s(n)=1+n+0.25*n.^2;
% sd(n)=1+0.5.*n;
% GN = 1/sqrt(2) * (randn(1,1) + 1i*randn(1,1));
% AWGN = 10000* GN;
% s=s+AWGN;
N=200;
var=25;
aa=sqrt(var)*randn(N,1);
plot(aa'+s)