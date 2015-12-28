clc
clear all
close all
format long G

t=-4:.05:4;

x=(-t.*exp(-.8.*(t.^2)).*exp(1i.*(1.7.*t.^2+.15.*t.^3)).*sin(1.6.*t)+...
exp(-.4.*(t.^2)).*exp(1i*(2.*t.^2+.1.*t.^3)).*cos(2.*t)+exp(-.5.*(t-.2).^2).*sin(t));


for k=1:length(x)
  n(k)=((rand-.5)+1i*(rand-.5))';
end
  f=x+n;

%figure(1)
%qwigner2(x)  

p=fracft(f,-.9);
%figure(2)
%qwigner2(p)  
% 
 q1=[zeros(1,70) ones(1,20) zeros(1,71)];
 ws=p.*q1';
 %figure(3)
 %qwigner2(ws)  
% 
s=fracft(ws,.9);
%figure(4)
%qwigner2(s)
% 
 q2=[zeros(1,27) ones(1,111) zeros(1,23)];
 wss=s.*q2';
 %figure(5)
 %qwigner2(wss)
% 
figure(6)
plot(real(wss))
hold on
plot(real(x))

pc=fracft(f,1);
%figure(7)
%qwigner2(pc)  

q4=[zeros(1,70) ones(1,20) zeros(1,71)];
 wc=pc.*q4';
 %figure(9)
 %qwigner2(wc)  
% 
sc=fracft(wc,-1);
%figure(10)
%qwigner2(sc)
% 
 q3=[zeros(1,27) ones(1,111) zeros(1,23)];
 wcc=sc.*q3';
 %figure(11)
 %qwigner2(wcc)
% 
figure(12)
plot(real(wcc))
hold on
plot(real(x))

wcc=wcc';
wss=wss';
hh=1:length(f);
 ddd=sum(abs((x(hh))).^2);
  ss1=sum((abs(real(wss(hh))-real(x(hh)))).^2)/ddd %frft
  ss2=sum((abs(real(wcc(hh))-real(x(hh)))).^2)/ddd %fft
  ss3=sum((abs(real(f(hh))-real(x(hh)))).^2)/ddd %noise inter
%  ss1=sum(((abs(wss(hh))-abs(x(hh)))).^2)/ddd %frft
%  ss2=sum(((abs(wcc(hh))-abs(x(hh)))).^2)/ddd %fft
%  ss3=sum(((abs(f(hh))-abs(x(hh)))).^2)/ddd %noise inter 

 
 





