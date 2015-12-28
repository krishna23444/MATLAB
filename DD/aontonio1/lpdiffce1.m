clc
clear all

format long G
pow=16;

load('F:\Users\JC\Documents\kall.mat')
m=Expression1;
omegap=m*pi;
tic
load('F:\Users\JC\Documents\xxall.mat')
hf=imag(Expression1);

load('F:\Users\JC\Documents\vall.mat')
v=Expression1;

S2=2^pow;
L=1;
p=0
q=1;
for i=ceil(m*p*S2):ceil(m*S2)
d(q)=((pi/S2)*i)^v;
q=q+1;
end
   
 figure(1)
for l=1:131
    

       [cc,vv]=freqz(hf(l,:),1,[0 .8]);
       
   AA=ceil(m*S2)-ceil(m*p*S2)+1;
[y,P]=freqz(hf(l,:),1,linspace(p*omegap,omegap,AA));
   
%      y=abs(y)-abs(cc(1));

   for i=1:AA
        e(i)=abs(abs(y(i))-d(i));
   end
       
  if mod(l,10)==0
      plot(d,'r')
       hold on
       plot(abs(y))
       pause(.1)
       hold off
  end
       
    L(l)=max(e);
   
end

figure(2)
semilogy(L)
grid on
toc