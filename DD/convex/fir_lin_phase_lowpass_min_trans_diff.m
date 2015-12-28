clc
clear all
close all

v=1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=((pi/(R/2))*i)^v;
end
wstop = 0.9*pi;        % stopband start freq (in radians)
TOL = 1e-3;             % precision to which we should run bisection

n = 17;                 % filter order (2n+1 is the full order)
wpass = 0.35*pi;        % passband cutoff freq (in radians)
delta = .15;            % max (+/-) passband ripple in dB
atten_level = -52;      % stopband attenuation level in dB

%********************************************************************
% create optimization parameters
%********************************************************************
m = 30*n; % freq samples (rule-of-thumb)
w = linspace(0,pi,m);

%*********************************************************************
% use bisection algorithm to solve the problem
%*********************************************************************

wstop_bot = wpass;
wstop_top  = wstop;

while(wstop_top - wstop_bot > TOL)
  % try to find a feasible design for given specs
  wstop_cur = (wstop_top + wstop_bot)/2;

  % create optimization matrices (matrix of cosines)
  A = [ones(m,1) 2*cos(kron(w',[1:n]))];

  % passband 0 <= w <= w_pass
  ind = find((0 <= w) & (w <= wpass));    % passband
  Ap  = A(ind,:);
  Lp  = ((w(ind)).^v).'+10^(-delta/20)*ones(length(ind),1)-1;
Up  =  ((w(ind)).^v).'+10^(+delta/20)*ones(length(ind),1)-1 ;

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
    fprintf(1,'Problem is feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_top = wstop_cur;
    % construct the full impulse response
    h = [flipud(h_cur(2:end)); h_cur];
  else % not feasible
    fprintf(1,'Problem is not feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_bot = wstop_cur;
  end
end

wstop1 = wstop_top;
fprintf(1,['\nOptimum stopband frequency for given specs is %3.4f*pi rads\n' ...
           'and the minimum transition width is %3.4f*pi radians.\n'],...
            wstop/pi, (wstop-wpass)/pi);


%********************************************************************
% plots
%********************************************************************
figure(1)
lp=u(1:(wpass/pi)*10000)+(10^(-delta/20)*ones(length((wpass/pi)*10000),1)-1);
up=u(1:(wpass/pi)*10000)+(10^(delta/20)*ones(length((wpass/pi)*10000),1)-1);

[H w]=freqz(h,1,10000);
H=abs(H);
plot(H,'k','LineWidth',1.7)
    hold on
    plot(lp,'--r')
    plot(up,'--r')
    xlabel('frequency in pi units');ylabel('Magnitude response');
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
grid on


for i=1:R/2
    E(i)=(u(i)-H(i))/pi;
end
th=find(E*1000/pi>=10);
figure(2)
plot(w(1:th(1))/pi,E(1:th)*1000/pi,'k','LineWidth',1.7);xlabel('Frequency (Hz)');ylabel('%age error');
grid on
set(1:2,'color','w');
number=[n wpass wstop atten_level delta];
aaa='mintw';
bbb='.tiff';
writeFig300dpi(1,strcat(aaa,num2str(number),bbb))