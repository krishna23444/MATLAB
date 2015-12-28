clc
clear all

format long G
pow=16;

load('F:\Users\JC\Documents\kall.mat')
k=Expression1;
omegap=k*pi;
tic
load('F:\Users\JC\Documents\xxall.mat')
hf=imag(Expression1);
load('F:\Users\JC\Documents\vall.mat')
v=Expression1;

S2=2^pow;
L=1;
p=0
q=1;
for i=0:S2-1
d(q)=((pi/S2)*i)^v;
q=q+1;
end
  for b=32500
%  figure(1)
for l=1:131
       [cc,vv]=freqz(hf(l,:),1,[0 .8]);
       
  
[y,P]=freqz(hf(l,:),1,linspace(0,pi,S2));
   
%     y=abs(y)-abs(cc(1));
y=abs(y);
%   y=y*(d(b)/y(b));
   for i=1:S2*k
        e(i)=abs(abs(y(i))-d(i));
    end
        if mod(l,10)==0
      plot(d,'r')
       hold on
       plot(abs(y))
  pause(.1)
       hold off
  end 
  
       
    L(b,l)=max(e);
   
end

figure(2)
semilogy(L(b,:))
grid on
toc
  end