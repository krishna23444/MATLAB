%% Program for plots of salesnick,fourier series, parks mcclellan, convex optimizaiton, maa differentiatorI
%for figure 3-4(omegap=0.35)
clc
clear all
close all
format long G
%%
load('F:\Users\JC\Documents\xx.mat');
hf=Expression1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=(2/R)*i;
end
%%
for num=15
figure
% for alp=-0.5:.1:-.2
for alp=-.3

bb=1;

for kk=2:num
bb(kk)=((kk-1)-alp-1)*bb(kk-1)/(kk-1);
end

imp=[-fliplr(bb(2:num)).*blackman(num-1).' 1 bb(2:num).*blackman(num-1).'];
[xf yf]=freqz(imp,1,R/2);

end

end

%% MAA coefficients low pass diff 1
la1=[1 -.4398 .4672 -.0403 -.017]; %MAA .35 coeffs
lb1=[.0386 .0772 0 -.0772 -.0386];
[ma1,maw1]=freqz(lb1,la1,R/2);ma1=abs(ma1);
% la2=[1 .0133 .4366 .0003 -.0092]; %MAA .42 coeffs
% lb2=[.0573 .1147 0 -.1147 -.0573 ];
% [ma2,maw2]=freqz(lb2,la2,R/2);ma2=abs(ma2);
% la3=[1 .6228 .5531 .0768 .0011]; %MAA .52 coeffs
% lb3=[.0897 .1794 0 -.1794 -.0897];
% [ma3,maw3]=freqz(lb3,la3,R/2);ma3=abs(ma3);
% la4=[1 1.624 1.171 .3223 .0265]; %MAA .7 coeffs
% lb4=[.1649 .3298 0 -.3298 -.1649 ];
% [ma4,maw4]=freqz(lb4,la4,R/2);ma4=abs(ma4);
% %% MAA coefficients low pass diff 2
% lla1=[1 -.9429 .3151 .1809 -.0691 -.0192]; %MAA .22 coeffs
% llb1=[.0092 .0277 .0185 0 -.0185  -.0277 -.0092];
% [lma1,lmaw1]=freqz(llb1,lla1,R/2);
% lla2=[1 -.4525 .2623 .1386 -.0427 -.0127]; %MAA .29 coeffs
% llb2=[0.0178 .0533 .0355 0 -.0355 -.0533 -0.0178];
% [lma2,lmaw2]=freqz(llb2,lla2,R/2);
% lla3=[1 .1501 .362 .1439 -.015 -.0068]; %MAA .38 coeffs
% llb3=[.0325 .0975 0.065 0 -0.065 -.0975 -.0325];
% [lma3,lmaw3]=freqz(llb3,lla3,R/2);

 %%  length(h) = K+2L+2 salesnick's filter responses and maa
 K=13;
  L = (-K+29)/2-1;  
h1 = lowdiff(K,L);
[H1,w1] = freqz(h1,1,R/2);
hh=abs(H1)/pi;
 plot(w1/pi,hh,'k','LineWidth',1.3);
hold on
grid on

plot(maw1(1:5000)/pi,u(1:5000),'-.c','LineWidth',1.7)
plot(maw1/pi,abs(ma1),'r','LineWidth',1.3)
%% fourier series diff plots
%  [Hf,wf] = freqz(hf,1,R/2);
% % ho=abs(Hf)*.1/abs(Hf(1000));
%    ho=abs(Hf)/pi;
% plot(wf/pi,ho,'LineWidth',1.3);

%% convex optimization 
v=1;
wstop = 0.513*pi;        % stopband start freq (in radians)
TOL = 1e-3; 
n = 14;                 % filter order (2n+1 is the full order)
wpass = 0.3509*pi;        % passband cutoff freq (in radians)
delta = .169;              % max (+/-) passband ripple in dB
atten_level = -45;      % stopband attenuation level in dB

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
    fprintf(1,'Problem is feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_top = wstop_cur;
    % construct the full impulse response
    hc = [flipud(h_cur(2:end)); h_cur];
  else % not feasible
    fprintf(1,'Problem is not feasible for stopband freq = %3.4f rads\n',wstop_cur);
    wstop_bot = wstop_cur;
  end
end

[Hfc,wfc] = freqz(hc,1,R/2);
   hoc=abs(Hfc)/pi;
plot(wfc/pi,hoc,'g','LineWidth',1.3);
plot(wfc/pi,abs(xf)-1,'-.g','LineWidth',1.7)
%% parks-mcclellan
load('D:\MATLAB 2010 Portable\bin\cvx\examples\filter_design\fipm.mat')
[Hfpm,wfpm] = freqz(Num,1,R/2);
   hopm=abs(Hfpm);
plot(wfc/pi,hopm,'-.r','LineWidth',1.3);
%% error plots

figure(2)
for i=1:R/2
    
    E(i)=u(i)-hh(i);
end
th=find(E*1000/pi>=10);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'k','LineWidth',1.3);legend('salesnick');
hold on

for i=1:R/2
    E(i)=u(i)-ma1(i);
end
th=find(E*1000/pi>=10);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'r','LineWidth',1.3);legend('alalouis');
grid on
% 
% for i=1:R/2
%     E(i)=u(i)-ho(i);
% end
% th=find(E*100/pi>=10);
% plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'LineWidth',1.3)
% grid on
for i=1:R/2
    E(i)=u(i)-hoc(i);
end
th=find(E*1000/pi>=10);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'g','LineWidth',1.3);legend('convex');

for i=1:R/2
    E(i)=u(i)-hopm(i);
end
th=find(E*1000/pi>=10);

plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'-k','LineWidth',1.3);xlabel('Frequency (Hz)');ylabel('%age error');;legend('Parks-McClennan');


