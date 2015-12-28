clc
clear all
v=1;
wstop = 0.511*pi;        % stopband start freq (in radians)
TOL = 1e-3; 
n = 14;                 % filter order (2n+1 is the full order)
wpass = 0.353*pi;        % passband cutoff freq (in radians)
delta = .169;              % max (+/-) passband ripple in dB
atten_level = -46;      % stopband attenuation level in dB

%********************************************************************
% create optimization parameters
%**********************freq samples (rule-of-thumb)**********************************************
m = 30*n; % 
w = linspace(0,pi,m);

%*********************************************************************
% use bisection algorithm to solve the problem
%*********************************************************************

wstop_bot = wpass;
wstop_top  = wstop;

while( wstop_top - wstop_bot > TOL)
  % try to find a feasible design for given specs
  wstop_cur = (wstop_top + wstop_bot)/2;

  % create optimization matrices (matrix of cosines)
  A = [ones(m,1) 2*cos(kron(w',[1:n]))];

  % passband 0 <= w <= w_pass
  ind = find((0 <= w) & (w <= wpass));    % passband
  Ap  = A(ind,:);
  Lp  = ((w(ind)).^v).'+10^(-delta/20)*ones(length(ind),1)-1;
Up  = ((w(ind)).^v).'+10^(+delta/20)*ones(length(ind),1)-1 ;

bb=find(Lp>=0);
Lp(1:bb(1)-1)=0;

  % transition band is not constrained (w_pass <= w <= w_stop)

  % stopband (w_stop <= w) (this is the changing constraint)
  ind = find((wstop_cur <= w) & (w <= pi));   % stopband
  As  = A(ind,:);

  % formulate and solve the feasibility linear-phase lp filter design
  cvx_begin quiet
    variable h_cur(n+1,1);
    % feasibility problem
    % passband bounds
    Ap*h_cur <= Up;
    Ap*h_cur >= Lp;
    % stopband bounds
    abs( As*h_cur ) <= 10^(atten_level/20);
  cvx_end

  % bisection
  if strfind(cvx_status,'Solved') % feasible
%     fprintf(1,'Problem is feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_top = wstop_cur;
    % construct the full impulse response
    hc = [flipud(h_cur(2:end)); h_cur];
  else % not feasible
%     fprintf(1,'Problem is not feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_bot = wstop_cur;
  end
end

[Hfc,wfc] = freqz(hc,1,20000/2);
   hoc=abs(Hfc)/pi;
plot(hoc);
%% parks-mcclellan