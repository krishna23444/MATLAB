function [R,rdrRange,esRange,sminr,sminEs]=esVrdrNoPlot(Pt,Gt,RCS,Ges,Freq)
% ESVRDRNOPLOT For use with GUI or programs which do not require a plot
% TODO: Help

%% Initiate variables
pt=Pt;              % Power transmitted [W]
ptdb=g2db(pt);      % power tx [dB]
gt=Gt;              % Tx ae gain [ratio]
gtdb=g2db(gt);      % Tx ae gain [dB]
gr=gt;              % Rx ae gain [ratio]
grdb=g2db(gr);      % Rx ae gain [dB]
ges=Ges;            % ES ae gain [ratio]
gesdb=g2db(ges);    % ES ae gain [dB]
rcs=RCS;            % radar cross section [m^2]
rcsdb=g2db(rcs);    % radar cross section [dB]
f=Freq;             % rdr operating frequency
xtol=5;           % tolerance for calculating x-axis limit
setLow=30;           % low preset limit for logspace / range
setHigh=60;          % high preset limit for logspace / range
rdrpw=1e-6;         % radar pulse width [s]
rdrbw=p2b(rdrpw);   % radar bandwidth   [Hz]  
esbw=1e9;           % ES bandwidth      [Hz]
xincr=false;        % flag for x-axis increasing limits

%% Set range
%---ES
ses=smin(esbw,800,20)-30;                   % Smin for ES system
res=esRmaxdb(ses,ptdb,gtdb,gesdb,f);        % range for ES system
rhigh=round(res)+xtol;                      % log limit high
%---RDR
srdr=smin(rdrbw,800,4)-30;                  % Smin for RDR system
rrdr=rmaxdb(srdr,ptdb,gtdb,grdb+30,rcsdb,f);% range for radar system
rlow=round(rrdr)-xtol;                      % log limit low
%---Check rlow rhigh to see if they are in the right order
if rlow>rhigh
    temp=rlow;
    rlow=rhigh;
    rhigh=temp;
end
%---Increase range only if greater than set limits
if setLow>rlow
    setLow=rlow;
    xincr=true;
end
if setHigh<rhigh
    setHigh=rhigh;
    xincr=true;    
end
R=logspace(setLow/10,setHigh/10);                 % Create logspace for plot

%% Smin and sensitivity arrays - create
sminr=ones(1,length(R));       % initiate Smin(RDR) for R samples
sminEs=ones(1,length(R));      % initiate Smin(ES) for R samples
rdrRange = g2db((rre(pt,R, rcs, f, gt, gr*1000)));   % Radar sensitivity array for the range
esRange = g2db((rre1(pt,R,f,gt,ges)));          % ES sensitivity array for the range
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

% Create db values that are not already created
Rdb=g2db(R);
esdetectdb=g2db(esdetect)
rdetectdb=g2db(rdetect)

%% Plot
hold on
plot(Rdb,rdrRange,Rdb,esRange,Rdb,sminr,Rdb,sminEs); 
xlim([setLow setHigh])
if esAdvantage>=0
    area([esdetectdb rdetectdb],[sminr(1) sminr(1)],'BaseValue',sminEs(1),'FaceColor','y')
    legend('RDR received signal','ES received signal','RDR Smin','ES Smin','ES Advantage','Location','SouthWest')
else
    area([esdetectdb rdetectdb],[sminr(1) sminr(1)],'BaseValue',sminEs(1),'FaceColor','r')
    legend('RDR received signal','ES received signal','RDR Smin','ES Smin','ES Disadvantage','Location','SouthWest')
end
if xincr
    text(setLow+2*xtol,srdr-40,'Note: x-axis limits','FontSize',12)
end
% % text(log10(rdetect)+.5,2/3*rdrRange(length(R)),'ES Advantage','Interpreter','Latex','FontSize',16,'FontWeight','bold','BackgroundColor','w')
xlabel('\bf{Range} [$10log_{10}(m)$]','Interpreter','Latex')
ylabel('\bf{Sensitivity} [$dB$]','Interpreter','Latex')
% % format long g
% esAdv_km=esAdvantage/1000
esAdv_nm=esAdvantage/nm;
annot=sprintf('ES Advantage is %0.2f nm',esAdv_nm);
text(rdetectdb+0.05,srdr+(ses-srdr)/2,annot,'FontSize',12)
% % format

% print -dpdf esadv.pdf