clc
clear all

format long G
pow=16;

load('F:\Users\JC\Documents\k.mat')
k=Expression1;
omegap=k*pi;
tic
load('F:\Users\JC\Documents\xxall.mat')
hf=imag(Expression1);
load('F:\Users\JC\Documents\v.mat')
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
for l=1:101
    gh=max(abs(hf(l,:)));
loc=find(abs(hf(l,:))==gh);
    if mod(v,2)==0
    
hf(l,loc)=hf(l,loc)-sum(hf(l,:));
    else

hf(l,loc(1))=hf(l,loc(1))-sum(hf(l,:))/2;
hf(l,loc(2))=hf(l,loc(2))-sum(hf(l,:))/2;
    end
%        [cc,vv]=freqz(hf(l,:),1,[0 .8]);


       
  
[y,P]=freqz(hf(l,:),1,linspace(0,pi,S2));
   
%     y=abs(y)-abs(cc(1));
y=abs(y);
%   y=y*(d(b)/y(b));
   for i=1:S2*k
        e(i)=abs(abs(y(i))-d(i));
   end
%         if mod(l,10)==0
%             figure(1)
%       plot(d,'r')
%        hold on
%        plot(abs(y))
%   pause(.1)
%        hold off
%        
%         end 
%   if l==66
%             figure(2)
%        plot(e)
%   end
  
       
    L(b,l)=max(e);
   
end
hold on
figure(3)
semilogy(L(b,:))
grid on

toc
  end
  hold on
  set(gca,'XTick',1:10:101,'XTickLabel','0|1|2|3|4|5|6|7|8|9|10')
xlabel('alpha')
ylabel('L(alpha,N)')