clc
clear all
close all

load('D:\MATLAB 2010 Portable\bin\DD\ecgsim1\MM!.mat')
figure(1)
plot(TIME(3*360:6*360), M(3*360:6*360,1),'r');
figure(2)
qwigner2(M(3*360:6*360,1))
