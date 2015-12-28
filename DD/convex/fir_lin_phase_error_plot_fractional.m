clc
clear all


mm=901;n = 30;lbd=1;v=0.5;
wpass = 1*pi;
wstop =pi;        % sband start freq (in radians)
atten_level = -10;      % stopd atuation level in dB

%********************************ban****ten*****top***************************
% create optimization parameters
%********************************************************************
N = 30*n+1;                            % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; % matrix of cosines
A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% passband 0 <= w <= w_pass

ind1 = find((0.09 <= w) & (w <= wpass));   % passband
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
 variable h(n,1);
    minimize( max(abs( Ap*h -(w(ind1).').^v)))% <= delta
cvx_end
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  hc = [-flipud(h);h];
end
% 
[Hfc,wfc] = freqz(hc,1,mm);
    hoc=abs(Hfc)
   %
   a3=[linspace(0,pi,mm)].^v;
%%
load('D:\MATLAB 2010 Portable\bin\DD\dnew\rbf_05_saved_paper_specs_1.mat');
[Hfc1,wfc] = freqz(b,1,mm);
    hoc1=abs(Hfc1);
grid on
for i=1:mm
    E(i)=a3(i)-hoc(i);
end
% th=find(E*1000/pi>=10);
th=150
plot(wfc(1:th)/pi,E(1:th),'LineWidth',2);
hold on
set(1,'color','w');
box on
grid on
for i=1:mm
    E1(i)=a3(i)-hoc1(i);
end
plot(wfc(1:th)/pi,E1(1:th),'r','LineWidth',2);
set(1,'color','w');
% 
% figure(2)
% hold on
% plot(a3)
% plot(hoc1)
% plot(hoc)
% grid on

