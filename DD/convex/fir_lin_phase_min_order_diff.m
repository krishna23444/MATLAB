clc
clear all
close all
v=1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=((pi/(R/2))*i)^v;
end
max_order = 17;

wpass = 0.35*pi;        % passband cutoff freq (in radians)
wstop = 0.5*pi;        % stopband start freq (in radians)
delta = .18;              % max (+/-) passband ripple in dB
atten_level = -53;      % stopband attenuation level in dB

%*********************************************%****************************
%**
% create optimization parameters

m = 30*max_order; % freq samples (rule-of-thumb)
w = linspace(0,pi,m);

%*********************************************************************
% use bisection algorithm to solve the problem
%*********************************************************************

n_bot = 1;
n_top = max_order;

disp('Rememeber that we are only considering filters with linear phase, i.e.,')
disp('filters that are symmetric around their midpoint and have order 2*n+1.')
disp(' ')

while( n_top - n_bot > 1)
  % try to find a feasible design for given specs
  n_cur = ceil( (n_top + n_bot)/2 );

  % create optimization matrices (this is cosine matrix)
  A = [ones(m,1) 2*cos(kron(w',[1:n_cur]))];

  % passband 0 <= w <= w_pass
  ind = find((0 <= w) & (w <= wpass));    % passband
  Ap  = A(ind,:);
  Lp  = ((w(ind)).^v).'+10^(-delta/20)*ones(length(ind),1)-1;
Up  =  ((w(ind)).^v).'+10^(+delta/20)*ones(length(ind),1)-1 ;

bb=find(Lp>=0);
Lp(1:bb(1)-1)=0;

  % transition band is not constrained (w_pass <= w <= w_stop)

  % stopband (w_stop <= w)
  ind = find((wstop <= w) & (w <= pi));   % stopband
  As  = A(ind,:);

  % formulate and solve the feasibility linear-phase lp filter design
  cvx_begin quiet
    variable h_cur(n_cur+1,1);
    % feasibility problem
    % passband bounds
    Ap*h_cur <= Up
    Ap*h_cur >= Lp;
    % stopband bounds
    abs( As*h_cur ) <= 10^(atten_level/20);
  cvx_end

  % bisection
  if strfind(cvx_status,'Solved') % feasible
    fprintf(1,'Problem is feasible for n = %d taps\n',n_cur);
    n_top = n_cur;
    % construct the full impulse response
    h = [flipud(h_cur(2:end)); h_cur];
  else % not feasible
    fprintf(1,'Problem not feasible for n = %d taps\n',n_cur);
    n_bot = n_cur;
  end
end

n = n_top;
fprintf(1,'\nOptimum number of filter taps for given specs is 2n+1 = %d.\n',...
           2*n+1);

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
number=[max_order wpass wstop atten_level];
aaa='minord';
bbb='.tiff';
writeFig300dpi(1,strcat(aaa,num2str(number),bbb))
