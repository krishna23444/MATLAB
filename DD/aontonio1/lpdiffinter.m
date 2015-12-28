clc
clear all
close all

load('F:\Users\JC\Documents\thir.mat')
gh=Expression1;

for k=1:15
    [hk,kh]=freqz(real(gh(k,:)),1);
    kj(k,:)=abs(hk);
    
end
surf(real(gh))
    