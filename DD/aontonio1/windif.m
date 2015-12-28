clc
clear all

load('F:\Users\JC\Documents\xx.mat')
h2=Expression1;
load('F:\Users\JC\Documents\v.mat')
v=Expression1;

    gh=max(abs(h2(:)));
loc=find(abs(h2(:))==gh);
    if mod(v,2)==0
    
h2(loc)=h2(loc)-sum(h2(:))
    else

h2(loc(1))=h2(loc(1))-sum(h2)/2;
h2(loc(2))=h2(loc(2))-sum(h2)/2;
    end

R=6280;
for k=0:R/2
    u(k+1)=((pi/(R/2))*k)^v;
end

K = 7;  L = 10;   %  length(h) = K+2L+2
h1 = lowdiff(K,L);
[H1,w1] = freqz(h1,1,R/2);
% plot(abs(H1),'r');
hold on
grid on
[H2,w2] = freqz(h2,1,R/2);

% lll=abs(H2);
% lll=lll-lll(1);
lll=abs(H2)
plot(lll);
 hold on
 plot(u)



% zz=abs(u(round(R/8)))/abs(xx(round(R/8)));
% yy=abs(u(round(R/8)))/abs(g(round(R/8)));
% figure(2)
%  plot(zz*abs(xx(1:R/2)))
% hold on
% grid on
%  plot(yy*abs(g(1:R/2)),'r')
%  plot(u)
% plot(20*log10(zz*abs(xx)/max(zz*abs(xx))))
%  hold on
% plot(20*log10(yy*abs(g)/max(yy*abs(g))),'r')