clc
clear all
close all

load('F:\Users\JC\Documents\d1.mat');
win=Expression1;

w=frft22d(extnn(win,100),[1 1]);

load('F:\Users\JC\Documents\d3.mat');
hh=Expression1;

h1=fft2(hh,100,100);

g=h1.*w;
g1=ifft2(g);
g2=fft2(g1,150,150);
surf(20*log10(abs(g2)));

