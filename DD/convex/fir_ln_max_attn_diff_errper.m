clc
clear all
close all
v=1.5;
R=20000;
for i=0:(R/2)-1
    u(i+1)=((pi/(R/2))*i)^v;
end

n = 15;
wpass = .35*pi;        % passband cutoff freq (in radians)
wstop = .5*pi;        % stopband start freq (in radians)
delta= .15;    % (delta) max allowed passband ripple in dB
                        % ideal passband gain is 0 dB

%*******************************************************************
% create optimization parameters*
%********************************************************************
N = 30*n;                              % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines

% passband 0 <= w <= w_pass
ind = find((0 <= w) & (w <= wpass));    % passband
Lp  = ((w(ind)).^v).'+(10^(-delta/20)*ones(length(ind),1)-1);
Up  = ((w(ind)).^v).'+(10^(+delta/20)*ones(length(ind),1)-1);
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
  variable h1(n+1,1);

  minimize( max( abs( As*h1 ) ) )
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
  h = [flipud(h1(2:end)); h1];
end

%********************************************************************
% plots
%********************************************************************
figure(1)
lp=u(1:0.35*10000)+(10^(-delta/20)*ones(length(0.35*10000),1)-1);
up=u(1:0.35*10000)+(10^(delta/20)*ones(length(0.35*10000),1)-1);

[H w]=freqz(h,1,10000);
H=abs(H);
plot(H)
    hold on
    plot(lp,'--r')
    plot(up,'--r')
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1*pi|0.2*pi|0.3*pi|0.4*pi|0.5*pi|0.6*pi|0.7*pi|0.8*pi|0.9*pi|pi')
grid on


for i=1:R/2
    E(i)=u(i)/pi-H(i)/pi;
end
th=find(E*1000/pi>=10);
figure(2)
plot(w(1:th(1))/pi,E(1:th)*1000/pi,'LineWidth',1.2);xlabel('Frequency (Hz)');ylabel('%age error');
grid on
set(1:2,'color','w');

