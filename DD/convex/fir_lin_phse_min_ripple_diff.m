clc
clear all
close all
R=20000;
for i=0:(R/2)-1
    u(i+1)=((pi/(R/2))*i);
end
%%
n = 21;
wpass =  0.4*pi;    % passband cutoff freq
wstop = 0.55*pi;    % sband start freq
atten_level = -50;  % stopband attenuation level

N = 30*n+1;  % frequency samples for approximation
w = linspace(0,pi,N);

A=2*sin(kron(w',1:n));   %type III matrix of sines

ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);

ind2 = find((wstop <= w) & (w <= pi));  % stopband
Us  = 10^(atten_level/20)*ones(length(ind2),1);
As  = A(ind2,:);

cvx_begin
  variable delta
  variable h(n,1);
  minimize( delta )
  subject to
   Ap*h<=w(ind1).'+ delta;    % passband bounds
   Ap*h>=[zeros(1,3) w(ind1(4:length(ind1)))-delta].';    

   abs( As*h ) <= Us;          % stopband bounds
cvx_end

h = [-flipud(h); 0;h]; %antisymmetric impulse response
   
%%
figure(1)
lp=u(1:(wpass/pi)* 10000)-delta;
up=u(1:(wpass/pi)* 10000)+delta;
lp(1:5)=0;

[H w]=freqz(h,1,10000);
H=abs(H);
plot(H,'k','LineWidth',1.7)
%     hold on
%     plot(lp,'--r')
%     plot(up,'--r')
    xlabel('frequency in pi units');ylabel('Magnitude');
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
grid on


for i=1:R/2
    E(i)=(u(i)-H(i))/pi;
end
th=find(E*1000/pi>=10);
figure(2)
plot(w/pi,E,'k','LineWidth',2);    xlabel('frequency in pi units');ylabel('Error');
grid on
set(1:2,'color','w');
%% impulse response plot
figure
yptt = spline(1:43,h,1:0.125:43);
plot(1:43,h,'o',1:.125:43,yptt,'--b','Linewidth',1.8)
hold on
stem(1:43,h,'r','Linewidth',1.5)
grid on
box on
set(3,'color','w');
% number=[n wpass wstop atten_level];
% aaa='minrip';
% bbb='.tiff';
% writeFig300dpi(1,strcat(aaa,num2str(number),bbb))
% writeFig300dpi(2,strcat(aaa,'err',num2str(number),bbb))

% fvtool(h,'Analysis','Grpdelay');