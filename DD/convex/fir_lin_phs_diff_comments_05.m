clc
clear all
close all
mm=901; n = 30; v=.5; lbd=1; wpass = lbd*pi; wstop = pi; atten_level = -10;

%************************b**an**t*****e***n*****top***************************
% create optimization parameters
%********************************************************************
N = 30*n+1;                            % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; %   pcosinesofmatrixassband
 A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% A=2*[sin(kron(w',[1:n]))]%type III
% passband 0 <= w <= w_pass
ind1 = find((0.09 <= w) & (w <= wpass));   % 
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
  h = [-flipud(h);h];
end

%********************************************************************
% plots
%********************************************************************
 figure(1)
[H xc]=freqz(h,1,mm);
xx=abs(H).';
plot(xx,'LineWidth',1.7);title('convex')
a3=[linspace(0,pi,mm)].^v;
hold on
grid on

plot(a3,'k','LineWidth',1.7)

pt=ceil(lbd*mm);
fx=(abs(a3(1:ceil(pt))-xx(1:ceil(pt)))).^2;
convex=(((fx(1)+fx(end))/2)+(sum(fx(2:end-1))))/mm;
%  H = exp(-j*kron(w',[0:2*(n-1)]))*h;
%  format long G
%  clear A
% N=10;
% to=5;
% 
% for i=0:N
%     for l=0:N
%     A(l+1,i+1)=(N+1-i)^l;
%     end
%     b(i+1)=gamma(i+1)*(N+1-to)^(i-v)/gamma(i+1-v);
% end
% h=inv(A)*b.';
% [f,d]=freqz(h,1,linspace(0,pi,151));
% a=[linspace(0,pi,151)].^v;
% % a=a./(10^6);

%%


%   sig=2.3;N=10;I=5;L=620;hh=0.05;v=1.5;ss=0;
% 
% for m=0:N
%     for k=0:L
%     ss=ss+((-1)^k)*gamma(v+1)*gee(m,I+k*hh,N,sig)/((hh^v)*gamma(k+1)*gamma(v-k+1));
%     end
%     b(m+1)=ss;
%     ss=0;
% end
load('rbf_05_saved_paper_specs_1.mat');
[H1,w]=freqz(b,1,mm);
grid on
hold on
% a=[linspace(0,pi,151)].^v;
% plot((1:151)*(pi/151),a,'r')
% x1=a(30)/abs(H(30));
figure(3)
plot(abs(H1),'LineWidth',1.7);title('radial basis')

hold on
plot(a3,'k','LineWidth',1.7)
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
  xlabel('frequency in pi units');ylabel('Magnitude response');
grid on
% legend('ideal','freq approx','Convex','Radial Basis','Location','NorthWest')
xx2=abs(H1).';
fx2=(abs(a3(1:pt)-xx2(1:pt))).^2;
radbas=(((fx2(1)+fx2(end))/2)+(sum(fx2(2:end-1))))/mm;
convex
radbas


% figure(4)
% subplot(1,2,2)
% plot(a3,'k','LineWidth',1.7)
% hold on
% plot(abs(H1),'LineWidth',1.7);title('radial basis')
% set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
%   xlabel('frequency in pi units');ylabel('Magnitude');
% grid on
% subplot(1,2,1)
% plot(a3,'k','LineWidth',1.7);
% hold on
% plot(xx,'LineWidth',1.7);title('convex')
% grid on
% set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
% xlabel('frequency in pi units');ylabel('Magnitude');


% set(1:3,'color','w');
% number=[N wpass hh v];
% aaa='minrip2mse';
% bbb='.tiff';
% writeFig300dpi(1,strcat('fa',aaa,num2str(number),bbb))
% writeFig300dpi(2,strcat('conv',aaa,num2str(number),bbb))
% writeFig300dpi(3,strcat('radbas',aaa,num2str(number),bbb))
% writeFig300dpi(4,strcat('subplotradbasfa',aaa,num2str(number),bbb))
%% loglog plot 
close all
loglog(w,abs(H),'r','LineWidth',2);
hold on
loglog(w,a3,'k','LineWidth',2);
loglog(w,xx2,'LineWidth',2);
% loglog(w,abs(H),'r','LineWidth',2);
% axis([10^-4 10^1 10^-5 10^1])
grid on
