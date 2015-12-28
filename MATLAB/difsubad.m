function [h,wind]=difsubad(itype,N,wp,ws,ddp,dds)
%-----------------------------------------------------
% Finds the parameters for the Kaiser (itype=1),
% Saramäki (itype=2), the Dolph-Chebyshev (itype=3),
% and the transitional window (itype=4) such that the
% the passband or stopband ripple criterion of the
% resulting differentiator is just met with 0.1%
% accuracy. The other one is less than the given value.
% dpp is the maximum deviation from omega in the
% passband from zero to wp, whereas dss is the maximum
% deviation from zero in the stopband from ws to unity.
% wp and ws are given as fractions of pi (half the
% sampling rate).
% If N is too low, the above is not possible.
% difwinad.m takes care of this and increases N.
%------------------------------------------------------
% firtyp=1,2,3,4 for lowpass, highpass, bandpass,
% and bandstop filters
%------------------------------------------------------
% The program returns both the filter coefficient h and
% the window function w. N is the length; the
% corresponding order is N-1.
%------------------------------------------------------
%------------------------------------------------------
% Tapio Saramäki 16.10.97
%------------------------------------------------------
% This can be found in SUN's: ~ts/matlab/dsp/difsubad.m
%------------------------------------------------------
dpp=ddp/(pi/(wp+ws)/2);
dp=dpp;
dss=dds/(pi/(wp+ws)/2);
ds=dss;
accuracy=1;
while accuracy == 1
if itype==1
[N1,alpha,wc]=kaiord(wp,ws,dp,ds);
wind=rot90(kaiser(N,alpha));
end
if itype==2
[N1,beta,wc]=sarord(wp,ws,dp,ds);
%wind=saramaki(N,beta);
wind=transit(N,beta,1); %faster
end
if itype==3
[N1,beta,wc]=dchord(wp,ws,dp,ds);
%wind=dcheb(N,beta);
wind=transit(N,beta,0); %faster
end
if itype==4
[N1,beta,rho,wc]=traord(wp,ws,dp,ds);
wind=transit(N,beta,rho);
end
wc=(wp+ws)/2;
h=firwind(N-1,wc,wind,'differentiator');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%h=2*h;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
[H,W]=freqz(h,1,8*1024);
na=round(ws*8*1024)+500/N;
nb=round(wp*8*1024)-500/N;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
amaxa=max(abs(H(na:8*1024)));
amaxb=max( abs( abs(W(1:nb))-abs(H(1:nb)) ) );
% figure(1)
% plot(W/pi,abs(H)/pi)
% figure(2)
% plot(W/pi,abs(W)-abs(H));pause
amaxa=amaxa/(pi/(wp+ws)/2);
amaxb=amaxb/(pi/(wp+ws)/2);
nda=-20*log10(dss)+20*log10(amaxa);
nda=-20*log10(ds)+nda;
ds=10^(-nda/20);
ndb=-20*log10(dpp)+20*log10(amaxb);
ndb=-20*log10(dp)+ndb;
dp=10^(-ndb/20);
if abs((amaxa-dss)/dss) < .0001 & amaxb < dpp
accuracy=0;
end
if (abs(amaxb-dpp)/dpp) < .0001 & amaxa < dss
accuracy=0;
end
if dp < dpp/10 & ds < dss/10
accuracy=0; % N is too low
end
end