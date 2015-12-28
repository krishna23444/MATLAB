clc
clear all
load('F:\Users\JC\Documents\vall.mat')
v=Expression1;
if v~=1
        errordlg('this script is for first order DD ','DD ERROR');
else
    
format long G
pow=15;
load('F:\Users\JC\Documents\kall.mat')
k=Expression1;
omegap=k*pi;
tic
load('F:\Users\JC\Documents\xxall.mat')
hf=imag(Expression1);

S2=2^pow;
L=1;
p=0
q=1;
for i=0:S2-1
d(q)=(pi/S2)*i;
q=q+1;
end
 
for l=1:131
   
[y,P]=freqz(hf(l,:),1,linspace(0,pi,S2));
     a=.1595;
     
    y=abs(y);

   for i=1:S2*k
        e(i)=abs(y(i)-d(i));
   end
   if mod(l,10)==0
      plot(d,'r')
       hold on
       plot(y)
       pause(1)
       hold off
  end
       
    L(l)=max(e);
   
end

figure(2)
semilogy(L)
toc
end