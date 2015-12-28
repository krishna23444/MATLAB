clc
clear all
close all
al=3.57;
load('F:\Users\JC\Documents\d1.mat');
win=Expression1;
load('F:\Users\JC\Documents\d2.mat');
tot=Expression1;
load('F:\Users\JC\Documents\d3.mat');
hh=Expression1;

figure(1)
%  surf(fftshift(abs(fft2(tot,100,100))))
surf(abs(fft2(tot,100,100)))

winmb=kaiser(25,al)*kaiser(25,al)';
fil=hh.*winmb;
figure(2)
surf(fftshift(20*log10(abs(fft2(fil,150,150)))))
