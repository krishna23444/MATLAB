clc
clear all
close all

x=16:-1:1;


phi=[1/sqrt(2) 1/sqrt(2)];
zi=[1/sqrt(2) -1/sqrt(2)];

a=conv(x,phi,'valid');
b=conv(x,zi,'valid');

c=a(1:2:length(a))
d=b(1:2:length(b))


a1=conv(c,phi,'valid');
b1=conv(c,zi,'valid');

c1=a1(1:2:length(a1))
d1=b1(1:2:length(b1))

a2=conv(d,phi,'valid');
b2=conv(d,zi,'valid');

c2=a1(1:2:length(a2))
d2=b1(1:2:length(b2))


