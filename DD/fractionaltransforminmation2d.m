clc
clear all
close all

load('F:\Users\JC\Documents\d3.mat');
hh=Expression1;

for a=0:.02:1
    surf(200*abs(frft22d(extnn(hh,150,150),[a a])));
    pause(.4);
end