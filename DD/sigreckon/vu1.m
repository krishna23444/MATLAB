clc
clear all
close all
nn=50;
load('D:\MATLAB 2010 Portable\bin\DD\sigreckon\UNIPEN-DTW.mat');
a=D{1,1};
b=D{1,2};
a=a(1:50,1:50)
b=b(1:50,1:50)
% a=int0(1,1:13);
% b=int0(2,1:13);
N=size(a);
for n=1:N(1)
    xy(:,n)=double([a(n,1);b(n,1)]);
plot(double(a(n,1)),double(b(n,1)),'ro')
hold on
end

t = 1:n;
ts = 1: 0.1: n;
xys = spline(t,xy,ts);
plot(xys(1,:),xys(2,:),'b-');

