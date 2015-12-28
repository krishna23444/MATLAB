clc
clear all
close all
%  load('D:\MATLAB 2010 Portable\bin\DD\dnew\imagesfordd\rmat445.mat')
n = 18;N = 30*n;w = linspace(0,pi,N);wpass=.75*pi;wstop=.9*pi;
%  A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines
%  A=[ones(N,1) exp(1i*kron(w',1:n))];
%   A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
  A=2*[sin(kron(w',[1:n]))];%type III
ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);
ind2 = find((wstop <= w) & (w <= pi));  % stopband
As  = A(ind2,:);

% qq=1;
% for v=0.05:.05:.4
    v=1.5;
cvx_begin
 variable h1(n,1);
    minimize( max(abs( Ap*h1 -(w(ind1).').^v)))% <= delta
    subject to 
    abs(As*h1) <=.015*ones(length(As),1);
    
%   sum((conv(r,h1)).^2)/5000<=.04
cvx_end
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  h = [-flipud(h1);0;h1];
end
% cb(qq)=sum((filter(h,1,r).^2))/5000;
% qq=qq+1;
% end

[H cc]=freqz(h,1,1000);
figure(1)
plot(abs(H),'k','LineWidth',1.7)
grid on
hold on
plot(linspace(0,pi,999).^v);
% load gong.mat;
% sound(y, Fs);