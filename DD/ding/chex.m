clc
clear all
a=-11:.1:11;
%% ding '07 (eq 47-48)
H= 2.*cos(5.*a).*exp(-a.^2/10);
z = .5.*exp(1i.*.23.*a.^2) + .5.*exp(1i.*.3.*a.^2 + 1i.*8.5.*a) +...
  .5.*exp(1i.*.46.*a.^2 - 1i.*9.6.*a);
f = H + z;
%% ding '07 (fig 3)
f0=exp(1i.*.15.*a.^3);
%% ding '10 (eq 137-138)
h0=-a.*exp(-.8.*(a.^2)).*exp(1i.*(1.7.*a.^2+.15.*a.^3)).*sin(1.6.*a)+...
exp(-.4.*(a.^2)).*exp(1i*(2.*a.^2+.1.*a.^3)).*cos(2.*a)+exp(-.5.*(a-.2).^2).*sin(a);
for k=1:length(h0)
  ng(k)=(rand-.5)+1i*(rand-.5);
  h1(k)=h0(k)+ng(k);
end
%% ding '07 (eq 13)
p2=exp(((1i.*a.^2)/2)+6.*1i.*a).*exp(-((a-4).^2)./10);
p1=exp(((1i.*a.^2)/10)-3.*1i*a).*((a>=-9)-(a>1));
p3=p2+p1;
%% ding '07 (fig 1-2)
b=[zeros(1,ceil(length(a)*3/10)) ones(1,ceil(length(a)*4/10)) zeros(1,ceil(length(a)*3/10+1))];
%% ding '01 (eq 33-34) 
g0=2.*exp(-.2.*a.^2).*((a>=-3)-(a>3));
g1=.5.*exp(1i.*.3.*(a+8.6).^2)+exp(-1i.*3*a).*exp(-.1.*(a-7).^2);
g2=g1+g0;
%% ding report on FrFT/LCT
o=exp(-a.^2./2);
oo=.7*exp((-3.4.*a+.032.*a.^3).*1i);
o1=o+oo;