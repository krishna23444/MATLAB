clc
clear all
close all
n = 10;
wpass = .9*pi;        % passband cutoff freq (in radians)
wstop = pi;        % stopband start freq (in radians)
delta= .5;    % (delta) max allowed passband ripple in dB
                        % ideal passband gain is 0 dB

%*******************************************************************
% create optimization parameters*
%********************************************************************
N = 30*n;                              % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
%   A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % type I
%  A=[exp(1i*kron(w',0:n))]%type 
%  A=2*[sin(kron(w',[1:n]))]%type III
A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))]%type IV
v=1;
% passband 0 <= w <= w_pass
ind = find((0 <= w) & (w <= wpass));    % passband
Lp  = (1i*(w(ind)).^v).'+(10^(-delta/20)*ones(length(ind),1)-1);
Up  = (1i*(w(ind)).^v).'+(10^(+delta/20)*ones(length(ind),1)-1);
Ap  = A(ind,:);
bb=find(Lp>=0);
Lp(1:bb(1)-1)=0;

% transition band is not constrained (w_pass <= w <= w_stop)
% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));   % stopband
As  = A(ind2,:);

%********************************************************************
% optimization
%********************************************************************
% formulate and solve the linear-phase lowpass filter design
cvx_begin
  variable h1(n,1);

  minimize( max( abs(As*h1) ) ) 
  subject to
    % passband bounds
    Lp <= Ap*h1;
    Ap*h1 <= Up;
cvx_end

% check if problem was successfully solved
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  fprintf(1,'The minimum attenuation in the stopband is %3.2f dB.\n\n',...
          20*log10(cvx_optval));
  % construct the full impulse response
  hh=[-flipud(h1); h1]
end
[H xx]=freqz(hh,1,N)
plot(abs(H))
    hold on
    plot(Up,'r')
    plot(Lp,'r')

set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1*pi|0.2*pi|0.3*pi|0.4*pi|0.5*pi|0.6*pi|0.7*pi|0.8*pi|0.9*pi|pi')
grid on
set(1,'color','w');