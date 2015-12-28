function [esAdv,rdetectrnge,esdetectrnge,sMinRdr,sMinEs]=esVrdr(Pt,Gt,Gr,RCS,Ges,RDRpw,ESbw,RDRsnr,ESsnr,Freq)
% ESVRDR Plots ES advantage and returns radar and ES parameters
% 
%   [esAdv,rdetectrnge,esdetectrnge,sMinRdr,sMinEs]=
%       esVrdr(Pt,Gt,Gr,RCS,Ges,RDRpw,ESpw,RDRsnr,ESsnr,Freq)
% 
%   OUTPUTS
%   esAdv        = The distance the max ES system detection range minus the
%                   max radar detection range.               [m]
%                   A negative result would mean that the radar actually  
%                   has an advantage over the ES system.
%   rdetectrnge  = Maximum detection range of the radar.     [m]
%   esdetectrnge = Maximum detection range of the ES system. [m]
%   sMinRdr      = Minimum sensitivity of the ES receiver.   [W]
%   sMinEs       = Minimum sensitivity of the ES receiver.   [W]
% 
%   INPUTS
%   Pt     = Transmitted power of the radar.                [W]
%   Gt     = Gain of the transmitter (source).              [ratio]
%   Gr     = Gain of the radar receiver (source).           [ratio]
%   RCS    = Radar Cross Section of the targeted platform (ie. aircraft the
%            receiver is mounted on).                       [m^2]
%   Ges    = Gain of the ES system (receiver) antenna.      [ratio]
%   RDRpw  = Radar signal pulse width.                      [s]
%   ESbw   = ES system bandwidth.                           [Hz]
%   RDRsnr = Radar singal to noise ratio.                   [dB]
%   ESsnr  = ES system singal to noise ratio.               [dB]
%   Freq   = Operating frequency of the radar transmitter.  [Hz]
% 
% 
%   TYPICAL VALUES
%   Pt = 5000 W
%   Gt = 1000 times
%   Gr = 1000 times
%   RCS = 3 m^2
%   Ges = 1 times
%   RDRpw = 1e-6 s
%   ESbw = 1e9 Hz
%   RDRsnr = 4 dB
%   ESsnr = 14 dB
%   Freq = 10e9 Hz
%   
% TODO: help file for esVrdr
% Copyright 2008

%% Initiate variables
pt=Pt;              % Power transmitted [W]
ptdb=g2db(pt);      % power tx [dB]
gt=Gt;              % Tx ae gain [ratio]
gtdb=g2db(gt);      % Tx ae gain [dB]
gr=Gr;              % Rx ae gain [ratio]
grdb=g2db(gr);      % Rx ae gain [dB]
ges=Ges;            % ES ae gain [ratio]
gesdb=g2db(ges);    % ES ae gain [dB]
rcs=RCS;            % radar cross section [m^2]
rcsdb=g2db(rcs);    % radar cross section [dB]
rpw=RDRpw;          % radar pulse width [s]
esbw=ESbw;          % ES bandwidth [Hz]
rsnr=RDRsnr;        % radar signal to noise [dB]
essnr=ESsnr;        % ES signal to noise [dB]
f=Freq;             % rdr operating frequency
xtol=0.5;           % tolerance for calculating x-axis limit

%% Set range
%---ES
ses=smin(esbw,800,rsnr);                    % Smin for ES system
res=esRmaxdb(ses,ptdb,gtdb,gesdb,f);        % range for ES system
rhigh=round(res)/10+xtol;                   % log limit high
%---RDR
srdr=smin(p2b(rpw),800,essnr);              % Smin for RDR system
rrdr=rmaxdb(srdr,ptdb,gtdb,grdb,rcsdb,f);   % range for radar system
rlow=round(rrdr)/10-xtol;                   % log limit low
%---Check rlow rhigh to see if they are in the right order
if rlow>rhigh
    temp=rlow;
    rlow=rhigh;
    rhigh=temp;
end
R=logspace(rlow,rhigh);                     % Create logspace for plot

%% Smin and sensitivity arrays - create
sminr=ones(1,length(R));       % initiate Smin(RDR) for R samples
sminEs=ones(1,length(R));      % initiate Smin(ES) for R samples
rdrRange = 10*log10(rre(pt,R, rcs, f, gt, gr));   % Radar sensitivity array for the range
esRange = 10*log10(rre1(pt,R,f,gt,ges));          % ES sensitivity array for the range
sminr=sminr.*srdr;             % Smin rdr array for the range
sminEs=sminEs.*ses;            % Smin es array for the range

% srdb=g2db(sminr(1))+30
% sesdb=g2db(sminEs(1))+30
    
%% Interpolate detection range
% figure
rdetect=interp1(rdrRange,R,sminr(1));
% radarRange_nm=rdetect/1852
esdetect=interp1(esRange,R,sminEs(1));
% esRange_nm=esdetect/1892
esAdvantage=esdetect-rdetect;

%% Plot
figure
hold on
plot(log10(R),rdrRange,log10(R),esRange,log10(R),sminr,log10(R),sminEs); 
xlim([rlow rhigh])
if esAdvantage>=0
    area([log10(esdetect) log10(rdetect)],[sminr(1) sminr(1)],'BaseValue',sminEs(1),'FaceColor','y')
    legend('RDR received signal','ES received signal','RDR Smin','ES Smin','ES Advantage','Location','SouthWest')
else
    area([log10(esdetect) log10(rdetect)],[sminr(1) sminr(1)],'BaseValue',sminEs(1),'FaceColor','r')
    legend('RDR received signal','ES received signal','RDR Smin','ES Smin','ES Disadvantage','Location','SouthWest')
end
title('Electronic Support Advantage','Interpreter','Latex','FontSize',16)
xlabel('\bf{Range} [$log_{10}(m)$]','Interpreter','Latex')
ylabel('\bf{Sensitivity} [$dB$]','Interpreter','Latex')
% esAdv_km=esAdvantage/1000
esAdv_nm=esAdvantage/nm;
annot=sprintf('ES Advantage is %0.2f nm',esAdv_nm);
text(log10(rdetect)+0.05,srdr+(ses-srdr)/2,annot,'FontSize',12)

% Return results
esAdv=esAdvantage;
rdetectrnge=rdetect;
esdetectrnge=esdetect;
sMinRdr=sminr(1);
sMinEs=sminEs(1);

% print -dpdf esadv.pdf