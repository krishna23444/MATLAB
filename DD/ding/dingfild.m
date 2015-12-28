clc
clear all
close all

t = 0:0.01:3;
x = chirp(t,2,3,50);

for k=1:length(x)
  n(k)=(rand-.5);
  f(k)=x(k)+n(k);
end

 figure(1)
 qwigner2(f)  

p=fracft(f,.71);
 figure(2)
 qwigner2(p)  
 
  q1=[zeros(1,75) ones(1,10) zeros(1,216)];
w=p.*q1';
figure(3)
qwigner2(w)  
 
s=fracft(w,-.71);
figure(4)
qwigner2(s)

 p1=fracft(f,1.28);
 figure(6)
 qwigner2(p1)  

 q2=[zeros(1,215) ones(1,10) zeros(1,76)];
 w1=p1.*q2';
 figure(5)
 qwigner2(w1)

 s1=fracft(w1,-1.28);
 S=s1+s;
figure(7)
qwigner2(S)
% 
figure(6)
plot(real(S))
hold on
plot(real(x))
figure(7)
plot(real(f))