clear all
clc
rf2 = @(x)myfn1(x); % objective
x0=0;
x1=12;
fminbnd(rf2,x0,x1)
% fminsearch(rf2,x0)
