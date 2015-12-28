%% Program to for plots of salesnick and maa differentiator\
clc
clear all
close all
format long G

R=6280;
for i=0:3139
    u(i+1)=(1/3140)*i;
end
%% MAA coefficients low pass diff 1
la1=[1 -.4398 .4672 -.0403 -.017]; %MAA .35 coeffs
lb1=[.0386 .0772 0 -.0772 -.0386];
[ma1,maw1]=freqz(lb1,la1,R/2);ma1=abs(ma1);
la2=[1 .0133 .4366 .0003 -.0092]; %MAA .42 coeffs
lb2=[.0573 .1147 0 -.1147 -.0573 ];
[ma2,maw2]=freqz(lb2,la2,R/2);ma2=abs(ma2);
la3=[1 .6228 .5531 .0768 .0011]; %MAA .52 coeffs
lb3=[.0897 .1794 0 -.1794 -.0897];
[ma3,maw3]=freqz(lb3,la3,R/2);ma3=abs(ma3);
la4=[1 1.624 1.171 .3223 .0265]; %MAA .7 coeffs
lb4=[.1649 .3298 0 -.3298 -.1649 ];
[ma4,maw4]=freqz(lb4,la4,R/2);ma4=abs(ma4);
%% MAA coefficients low pass diff 2
lla1=[1 -.9429 .3151 .1809 -.0691 -.0192]; %MAA .22 coeffs
llb1=[.0092 .0277 .0185 0 -.0185  -.0277 -.0092];
[lma1,lmaw1]=freqz(llb1,lla1,R/2);
lla2=[1 -.4525 .2623 .1386 -.0427 -.0127]; %MAA .29 coeffs
llb2=[0.0178 .0533 .0355 0 -.0355 -.0533 -0.0178];
[lma2,lmaw2]=freqz(llb2,lla2,R/2);
lla3=[1 .1501 .362 .1439 -.015 -.0068]; %MAA .38 coeffs
llb3=[.0325 .0975 0.065 0 -0.065 -.0975 -.0325];
[lma3,lmaw3]=freqz(llb3,lla3,R/2);

 %%  length(h) = K+2L+2 salesnick's filter responses and maa
for K=13
L = (-K+29)/2-1;
h1 = lowdiff(K,L);
[H1,w1] = freqz(h1,1,R/2);
hh=abs(H1)/pi;
%  plot(w1/pi,hh);
hold on
grid on
end
plot(maw1/pi,u)
hold on
grid on

plot(maw4/pi,abs(ma1),'r')
plot(maw4/pi,abs(ma2),'r')
plot(maw4/pi,abs(ma3),'r')
plot(maw4/pi,abs(ma4),'r')
%% error plots
for i=1:3140
    E(i)=u(i)-ma1(i);
end
figure(2)
% plot(maw1(1:1253)/pi,E(1:1253)*1000/pi);xlabel('Frequency (Hz)');ylabel('Magnitude Response');
hold on
for i=1:3140
    E(i)=u(i)-hh(i);
end
% plot(maw1(1:1291)/pi,E(1:1291)*1000/pi);xlabel('Frequency (Hz)');ylabel('Magnitude Response');
grid on
