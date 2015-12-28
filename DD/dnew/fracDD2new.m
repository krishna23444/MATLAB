clear all

clc

% load('F:\Users\JC\Documents\q.mat');
% v=Expression1;
% load('F:\Users\JC\Documents\Ta.mat');
% Ta=Expression1;
% load('F:\Users\JC\Documents\Tb.mat');
% Tb=Expression1;
% load('F:\Users\JC\Documents\Ib.mat');
% Ib=Expression1;
% load('F:\Users\JC\Documents\Ia.mat');
% Ia=Expression1;
%  b=inv(Tb)*Ib;
%  a=inv(Ta)*Ia;
 a1=[-1.5865 1.669298 -0.2345 0.1607012 -0.04317 0.03417];
  b1=[1.719192 -0.969756 0.3680268 -0.164681 0.0316680];
% a1=zeros(1,6);
% b1=[1.858 -.7398 0.3288 -.13 0.037];
v=1.5;
%  a1=abs(a.');
%  b1=abs(b.');
a2=(a1(2:6)+b1)/2;
b2=(a1(2:6)-b1)/2;
c=[fliplr(a2) a1(1) b2];
bz=1;
for mm=300
[x NN]=freqz(c,1,mm);
a3=[linspace(0,pi,mm)].^v;
% x1=a3(48)/abs(x(48));
figure(2)
plot((1:mm)*(pi/mm),a3);
hold on
xx=abs(x).';
plot((1:mm)*(pi/mm),xx,'r')
grid on

lbd=.72;
pt=mm*lbd;
fx=(abs(a3(1:ceil(pt))-xx(1:ceil(pt)))).^2;
z2=sqrt((((fx(1)+fx(end))/2)+(sum(fx(2:end-1))))*pi*lbd/pt) 
% su(bz)=sum(fx)
% E(bz)=sqrt(sum(fx)/(2*lbd*pi));
bz=bz+1;
end
