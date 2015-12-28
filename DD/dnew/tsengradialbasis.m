clc
clear all
close all
    sig=2.3;N=10;I=5;L=620;h=0.05;v=1.5;ss=0;%I
   %sig=2.3;N=60;I=9;L=620;h=0.3;v=0.5;ss=0;%II
%     sig=2.3;N=80;I=20;L=620;h=0.2;v=0.5;ss=0;%III
%      sig=2.3;N=60;I=30;L=620;h=0.1;v=0.15;ss=0;%fracnoise


lbd=0.7;
pt=ceil(151*lbd);
for m=0:N
    for k=0:L
    ss=ss+((-1)^k)*gamma(v+1)*gee(m,I+k*h,N,sig)/((h^v)*gamma(k+1)*gamma(v-k+1));
    end
    b(m+1)=ss;
    ss=0;
end
[H,w1]=freqz(b,1,151);
grid on
hold on
a=([linspace(0,pi,151)].^v).';
plot((1:151)*(pi/151),a,'r')
% x1=a(30)/abs(H(30));
plot((1:151)*(pi/151),abs(H))
xx2=abs(H);
fx2=(abs(a(1:pt)-xx2(1:pt))).^2;
radbas=(((fx2(1)+fx2(end))/2)+(sum(fx2(2:end-1))))*lbd/pt
load gong.mat;
sound(y, Fs);
