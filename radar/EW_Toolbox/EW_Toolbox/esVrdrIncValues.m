function [R,rdrRange,esRange,sr,ser]=esVrdrIncValues
% ESVRDRINCVALUES  Typical ES and RDR values produce plot of ES advantage
% 
% TODO: Complete help

R=logspace(3,7);  % test range (start with one to negate inf result at 0)
pt=5e3;     % Power transmitted [W]
gt=db2g(30);    % Ae Tx Gain [ratio]
gr=gt;      % Ae Rx Gain [ratio]
ges=1;
rcs=3;      % radar cross section
f=9.5e9;      % rdr operating frequency

length(R);
sr=ones(1,length(R));   % initiate Smin(RDR) for R samples
ser=ones(1,length(R));  % initiate Smin(ES) for R samples


rdrRange = 10*log10(rre(pt,R, rcs, f, gt, gr));   % Radar range sensitivity
esRange = 10*log10(rre1(pt,R,f,gt,ges));           % ES range sensitivity



sr=sr.*smin(p2b(1e-6),800,4);        % Smin rdr 
sr(1)
ser=ser.*smin(p2b(1e-6),800,14);     % Smin es

srdb=g2db(sr(1))+30
serdb=g2db(ser(1))+30
    
figure
rdetect=interp1(rdrRange,R,sr(1))
radarRange_nm=rdetect/1852
esdetect=interp1(esRange,R,ser(1))
esRange_nm=esdetect/1892
hold on
area([log10(esdetect) log10(rdetect)],[sr(1) sr(1)],'BaseValue',ser(1),'FaceColor','y')
plot(log10(R),rdrRange,log10(R),esRange,log10(R),sr,log10(R),ser);
esAdvantage=esdetect-rdetect;
legend('ES Advantage','RDR received signal','ES received signal','RDR Smin','ES Smin','Location','SouthWest')
% text(log10(rdetect)+.5,2/3*rdrRange(length(R)),'ES Advantage','Interpreter','Latex','FontSize',16,'FontWeight','bold','BackgroundColor','w')
xlabel('\bf{Range} [$log_{10}(m)$]','Interpreter','Latex')
ylabel('\bf{Sensitivity} [$dB$]','Interpreter','Latex')
% format long g
esAdv_km=esAdvantage/1000
esAdv_nm=esAdvantage/1852
% format

print -dpdf esadv.pdf