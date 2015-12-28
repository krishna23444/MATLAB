% Low pass IIR Digital differentiator
% weighted Inverse Simpson and trapezoidal scheme
% by Dr Yangquan Chen, 21-09-97
% Email=<yqchen@ieee.org>; URL=http://www.crosswinds.net/~yqchen/
% calling format [b,a]=lpiirdd(alpha)
% alpha \in [0,1]; 0: inverse trapezoidal
%                  1: inverse Simpson
%                  0.8529 (0.8496) Tick
%
function [b,a]=lpiirdd(alpha)
% alpha \in [0,1]
warning off;
figure
r1=(3+alpha+2*sqrt(3*alpha))/(3-alpha)
r2=(3+alpha-2*sqrt(3*alpha))/(3-alpha)
r20=1/r2; % assume r2>1 first
if (abs(r1)>abs(r2)); r20=1/r1; end
   
% note: r1=1/r2
gain=r20*6/(3-alpha);
b(1)=gain;b(2)=0;b(3)=-gain;
a(1)=1;a(2)=2*r20;a(3)=r20*r20;

sys_d=tf(b,a,1) 

w=(0:1000)*pi/1000;

[mag,phase,w1]=bode(sys_d,w);

subplot(2,2,1);hold on;plot(w1,abs(mag(1,:)))
xlabel('freq.  (0-pi)');ylabel(' mag. (dB)');ax=axis; 
axis equal;ax=axis; ax(3)=0;ax(4)=pi; axis(ax)
subplot(2,2,2);hold on;plot(w1,phase(1,:))
xlabel('freq.  (0-pi)');ylabel('phase (deg.)')

subplot(2,2,3);hold on;semilogx(log10(w1),20*log10(abs(mag(1,:))))
xlabel('freq. log. (0-pi)');ylabel(' mag. (dB)')
subplot(2,2,4);hold on;semilogx(log10(w1),phase(1,:))
xlabel('freq. log. (0-pi)');ylabel('phase (deg.)')

warning on;
return
 