clc
clear all
close all
nn=50;
load('D:\MATLAB 2010 Portable\bin\DD\sigreckon\upendig.mat');
a=double(int0(1,1:12))';
b=double(int0(2,1:12))';
N=size(a);
u=1;
for n=1:N(1)
    xy(:,u)=[a(n,1);b(n,1)];
plot(a(n,1),b(n,1),'ro')
hold on
u=u+1;
end

t = 1:N(1);
ts = 1: 0.1: N(1);
xys = spline(t,xy,ts);
plot(xys(1,:),xys(2,:),'b-');

