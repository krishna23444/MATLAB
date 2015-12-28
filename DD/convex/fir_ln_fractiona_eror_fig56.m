clc
% clear all
close all
mm=4000; n = 5; v=1.5; lbd=.72; wpass = lbd*pi; wstop = pi; atten_level = -50;

%************************b**an**t*****e***n*****top***************************
% create optimization parameters
%********************************************************************
N = 30*n+1;                            % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; %   pcosinesofmatrixassband
 A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% A=2*[sin(kron(w',[1:n]))]%type III
% passband 0 <= w <= w_pass
ind1 = find((0 <= w) & (w <= wpass));   % 
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
xx12=abs(H).';

a3=[linspace(0,pi,mm)].^v;
%%
 
a1=[-1.5865 1.669298 -0.2345 0.1607012 -0.04317 0.03417];
  b1=[1.719192 -0.969756 0.3680268 -0.164681 0.0316680];
  
a2=(a1(2:6)+b1)/2;
b2=(a1(2:6)-b1)/2;
c=[fliplr(a2) a1(1) b2];
bz=1;

[xz NN]=freqz(c,1,mm);

% x1=a3(48)/abs(x(48));
figure(1)
plot(a3,'k','LineWidth',1.7);
hold on
xx1=abs(xz).';
plot(xx1,'LineWidth',1.7);title('frequency approx')
grid on
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
xlabel('frequency in pi units');ylabel('Magnitude response');
grid on
%%

  sig=2.3;N=10;I=5;L=620;hh=0.05;v=1.5;ss=0;

for m=0:N
    for k=0:L
    ss=ss+((-1)^k)*gamma(v+1)*gee(m,I+k*hh,N,sig)/((hh^v)*gamma(k+1)*gamma(v-k+1));
    end
    b(m+1)=ss;
    ss=0;
end
[H1,w]=freqz(b,1,mm);
xx2=abs(H1);
grid on
hold on
% a=[linspace(0,pi,151)].^v;
% plot((1:151)*(pi/151),a,'r')
% x1=a(30)/abs(H(30));
figure(3)
plot(a3,'k','LineWidth',1.7)
hold on
plot(xx2,'LineWidth',1.7);title('radial basis')
set(gca,'XTick',0:length(H)/10:length(H),'XTickLabel','0|0.1  |0.2  |0.3  |0.4  |0.5  |0.6  |0.7  |0.8  |0.9  | 1')
  xlabel('frequency in pi units');ylabel('Magnitude response');

%%
grid on
for i=1:mm
    E(i)=a3(i)-xx1(i);
end
figure
plot(xc/pi,E,'LineWidth',2);
set(1,'color','w');
box on
grid on
hold on

for i=1:mm
    E(i)=a3(i)-xx2(i);
end
th=find(E*1000/pi>=10);
plot(xc/pi,E,'r','LineWidth',2);

box on

for i=1:mm
    E(i)=a3(i)-xx12(i);
end
th=find(E*1000/pi>=10);
plot(xc/pi,E,'k','LineWidth',2);
set(1,'color','w');
box on
grid on
set(3,'color','w');