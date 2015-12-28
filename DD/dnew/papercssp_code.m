clc
clear all
close all
n = 21;mm=901;lbd=.52;pt=ceil(lbd*mm);delta=0.001
N = 30*n;                              % freq samples (rule-of-thumb)
w = linspace(0,pi,N);wpass=lbd*pi;wstop=(lbd+.5)*pi;
%  A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines
%  A=[ones(N,1) exp(1i*kron(w',1:n))];
%  A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
A=2*[sin(kron(w',[1:n]))]%type III sin grid
ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);

% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));  % stopband
As  = A(ind2,:);
v=1;
% passband 0 <= w <= w_pass
cvx_begin
 variable h(n,1);
    minimize( max(abs( Ap*h -(w(ind1).').^v)))% <= delta
    subject to 
    As*h <=delta;
cvx_end
  h = [-flipud(h);0;h];

a3=[linspace(0,pi,mm)].^v;
 plot(a3,'r')
 
 save('b.mat','h');
 hold on
[H cc]=freqz(h,1,mm)
plot(abs(H),'k','LineWidth',1.7)
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1*pi|0.2*pi|0.3*pi|0.4*pi|0.5*pi|0.6*pi|0.7*pi|0.8*pi|0.9*pi|pi')
grid on
hold on
plot(a3,'r')
set(1,'color','w');
xx=abs(H).';
fxc=(abs(a3(1:ceil(pt))-xx(1:ceil(pt)))).^2;
convex=sqrt((((fxc(1)+fxc(end))/2)+(sum(fxc(2:end-1))))*pi*lbd/pt)