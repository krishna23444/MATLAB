% Reads the time data from Philips SDAT file. 
% function [X1,index_ppm]=philipsSDAT(filename,num)
%num= number spectra
clc;clear all;close all;
format long
% reading VAX format files in MATLAB10
filename='19F_2D_Pulacq_14_14_2_raw_act.SDAT';
num=2004;
fid = fopen(filename,'r','ieee-le');
X = freadVAXG(fid, 100000000,'float'); 
fclose(fid);
j = 1;
for i =1+2048*(num-1):2:2048*(num)
    X_real(j) = X(i);
    X_imag(j) = X(i+1);
    j = j + 1; 
end 
X_real = X_real';
X_imag = X_imag';
%Each data point is a complex pair with real, imaginary,real, imaginary..
% Complex conjugate the data if BRUKER = T. 
X1 = conj(complex(X_real,X_imag));
X_FT = fft(X1);
X_FT_shift = fftshift(X_FT);
plot(real(X_FT_shift))


% check the number of points to be plotted it should be 2048
% index_points = 1:1:1024;
% index = (index_points -129.448433)*1000000/127793081;
% index_ppm = index;
% whos
% X = X1(1:2048) + X1(2049:4096);
% subplot(2,1,1); plot(index, X_real(1:2048));
% subplot(2,1,2); plot(index, X_real(2049:4096));
% subplot(3,1,3); plot(index, real(X));
% figure;


