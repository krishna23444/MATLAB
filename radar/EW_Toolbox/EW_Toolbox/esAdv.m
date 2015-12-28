function [maxRange maxRangedb] = esAdv(Srdr, Pt, Gt, rcs, opFreq, Gr, SminEs, Ges)
% ESADV Returns the maximum range an ES system has over a radar
% 
%   maxRange = esAdv(Srdr, Pt, Gt, rcs, opFreq, Gr, SminEs, Ges)
% 
%   OUTPUTS
%   maxRange   = The difference in range between the maximum detection 
%                range of the ES system compared to the maximum range of 
%                the radar system. [m]
%                A negative result would mean that the radar actually has 
%                an advantage over the ES system.
%   maxRangedb = As above in decibels [dB]
% 
%   INPUTS
%   Srdr   = Minimum sensitivity of the radar.          [dBW]
%   Pt     = Transmitted power of the radar.            [dBW]
%   Gt     = Gain of the transmitter (source).          [dB]
%   rcs    = Radar Cross Section of the targeted platform (ie. aircraft the
%            receiver is mounted on).                   [dB(m^2)]
%   opFreq = Operating frequency of the radar transmitter. [Hz]
%   Gr     = Gain of the radar receiver (source).       [dB]
%   SminEs = Minimum sensitivity of the ES receiver.    [dBW]
%   Ges    = Gain of the ES system (receiver) antenna.  [dB]
% 
%   AIM: 
%   To find the maximum range at which the ES system can see the radar,
%   without the radar seeing the platform carrying the ES system.
% 
%   TECHNICAL BACKGROUND: 
%   TODO: Tech background
% 
%   REFERENCES: 
%   Name, Title, Publisher, Year
% 
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008
% 
%   See also rangedb, range1db

%   Copyright 2008

Rrdr=rangedb(Srdr,Pt,rcs,Gt,Gr,opFreq); % Max radar detection range [dB]
Res=range1db(SminEs,Pt,Gt,Gr,opFreq);   % Max ES detection range [dB]
maxRangedb=Res-Rrdr;                    % The advantage the ES receiver 
                                        %   has over the radar [dB]
maxRangedb=db2g(maxRangedb);            % as above [m]