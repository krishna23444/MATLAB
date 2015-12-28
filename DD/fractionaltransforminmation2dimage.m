clc
clear all
close all

hh=imread('D:\MATLAB 2010 Portable\bin\MATLAB\bw5.jpg');

for a=0:.05:1
    surf(abs(frft22d(extnn(hh,500,500),[a a])));
    pause(.2);
end