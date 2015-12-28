clc
clear all
close all
mm=4000; n = 3; v=.5; lbd=.9; wpass = pi; wstop = pi; atten_level = -50;
load('D:\MATLAB 2010 Portable\bin\DD\dnew\imagesfordd\rmat.mat')

%************************b**an**t*****e***n*****top***************************
% create optimization parameters
%********************************************************************
N = 30*n+1;                            % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; %   pcosinesofmatrixassband
 A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))]%type IV
% A=2*[sin(kron(w',[1:n]))]%type III
% passband 0 <= w <= w_pass
ind1 = find((0.1 <= w) & (w <= wpass));   % 
Ap  = A(ind1,:);

% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));  % stopband
Us  = 10^(atten_level/20)*ones(length(ind2),1);
As  = A(ind2,:);


cvx_begin
  variable delta
  variable h1(n,1);

  minimize( delta )
  subject to
    % passband bounds
    Ap*h1 <=(w(ind1).').^v+ delta;
    Ap*h1 >= [zeros(1,18) ((w(ind1(19:length(ind1)))).^v)-delta].';
sum((conv(r,h1)).^2)/5000<=0.7;
    % stopband bounds
%     abs( As*h ) <= Us;
cvx_end

% check if problem was successfully solved
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  % construct the full impulse response
  h = [-flipud(h1);h1];
end

%********************************************************************
% plots
%********************************************************************
 figure(1)

[H xc]=freqz(h,1,mm);
xx=abs(H).';
plot(xx);
hold on
plot(linspace(0,pi,mm).^v);