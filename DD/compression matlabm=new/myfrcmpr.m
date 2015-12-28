clc
clear all
a=imread('D:\MATLAB 2010 Portable\bin\DD\lenaoriginal.jpg');
s=size(a)
%a=rgb2gray(b);
a=double(a);
m=256;
n=256;
i=0.9
j=1;
c=[];
k=60
encoded=blkproc(a,[8,8],'fracF2D',i,i);
encoded(abs(encoded)<k)=0;
decoded=round(blkproc(encoded,[8,8],'fracF2D1',i,i));