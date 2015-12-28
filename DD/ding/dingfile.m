clc
clear all
close all

t = linspace(0,2,151);
x = chirp(t,2,2,10);

for k=1:length(x)
  n(k)=2*(rand-.5)+2i*(rand-.5);
  f(k)=x(k)+n(k);
end

 figure(1)
 qwigner2(f)  

p=fracft(f,.925);
 figure(2)
 qwigner2(p)  

   q1=[zeros(1,60) ones(1,5) zeros(1,86)];
w=p.*q1';
figure(3)
qwigner2(w)  
 
s=fracft(w,-.925);
figure(4)
qwigner2(s)

 p1=fracft(f,1.07);
 %figure(6)
 %qwigner2(p1)  
%
 q2=[zeros(1,85) ones(1,5) zeros(1,61)];
 w1=p1.*q2';
 %figure(5)
 %qwigner2(w1)

s1=fracft(w1,-1.07);
S=s1+s;
%figure(7)
%qwigner2(S)

figure(6)
plot(real(S),'b')
hold on
plot(real(x),'r')
figure(7)
plot(real(f))
%%
pc=fracft(f,1);
%figure(7)
%qwigner2(pc)  

q4=[zeros(1,50) ones(1,50) zeros(1,51)];
 wc=pc.*q4';
 %%figure(9)
 %%qwigner2(wc)  
% 
sc=fracft(wc,-1);
%figure(10)
%qwigner2(sc)

figure(12)
plot(real(sc),'b')
hold on
plot(real(x),'r')

sc=sc';
S=S';
hh=1:length(f);
 ddd=sum(abs((x(hh))).^2);
  FrFT=sum((abs(real(S(hh))-real(x(hh)))).^2)/ddd %frft
  FFT=sum((abs(real(sc(hh))-real(x(hh)))).^2)/ddd %fft
  noisy=sum((abs(real(f(hh))-real(x(hh)))).^2)/ddd %noise inter
