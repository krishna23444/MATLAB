clear all
filename='D:\MATLAB 2010 Portable\bin\DD\dnew\london.img';
m=512;
n=m;
 fp=fopen(filename,'r');
 a = fread(fp,[m,n],'uint8');
 imshow(a,[0,255])