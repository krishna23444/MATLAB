clc
% d=circshift(d',[0  -find(abs(d)/max(abs(d))==1)])

clear all
close all
f=.25;
w=2*pi*f;
n=17;
for a=1:-.3:.4

w1=hanning(35);
d=fracft([w1' zeros(1,964)],1);

% d=circshift(d',[0  -find(abs(d)/max(abs(d))==1)])
%  d=circshift(d',[0 -20]) 
%   figure(1)
%  plot(20*log10(real(d)/max(real(d))))
%  hold on

 
for i=-n:n
     hd(i+n+1)=2*f*sin(w*i)/(w*i);
 
 end
 hd(n+1)=2*f;
   H=fracft([hd zeros(1,964)],a);
%  H=[ones(1,125) zeros(1,250) ones(1,125)]
   g=d.*H
 
%    g=cconv(d,H,500)
%  g=frft([h' zeros(1,200)],a);
g1=fracft(g,-1);
g2=fracft([g1' zeros(1,900)],1)
figure(1)
hold on
plot(20*log10(abs(g2)/max(abs(g2))))
grid on
end