clc
clear all
close all
N=29;

load('F:\Users\JC\Documents\h.mat')
h0=Expression1;

x0=kaiser(N,alp).*hf;

