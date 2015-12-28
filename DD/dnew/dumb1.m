clc
clear all
close all
mm=901;n = 10;lbd=1;v=1;
wpass =pi;
wstop = pi;        % sband start freq (in radians)
atten_level = -10;      % stopd atuation level in dB

%********************************ban****ten*****top***************************
% create optimization parameters
%********************************************************************
N = 30*n+1;                            % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; % matrix of cosines
A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% passband 0 <= w <= w_pass
ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);

% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));  % stopband
Us  = 10^(atten_level/20)*ones(length(ind2),1);
As  = A(ind2,:);

%********************************************************************
% optimization
%********************************************************************
% formulate and solve the linear-phase lowpass filter design
cvx_begin
  variable delta
  variable h(n,1);

  minimize( delta )
  subject to
    % passband bounds
%     Ap*h <=(w(ind1).').^v+ delta;
%     Ap*h >= ((w(ind1).').^v)-delta;
 Ap*h <=(w(ind1).').^v+ delta;
    Ap*h >= [(w(ind1)).^v-delta].';
    % stopband bounds
%     abs( As*h ) <= Us;
cvx_end

% check if problem was successfully solved
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  % construct the full impulse response
  hc =[-flipud(h);h];
  
end
[H1 ww]=freqz(hc,1,mm);
 hold on
 plot(abs(H1),'k','LineWidth',1.7)
 a3=[linspace(0,pi,mm)].^v;
 plot(a3,'r')
 pt=ceil(lbd*mm);
 xx=abs(H1).';
fxc=(abs(a3(1:ceil(pt))-xx(1:ceil(pt)))).^2;
convex=sqrt((((fxc(1)+fxc(end))/2)+(sum(fxc(2:end-1))))*pi*lbd/pt)
grid on
