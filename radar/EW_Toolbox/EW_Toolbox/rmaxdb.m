function [Rdb R]=rmaxdb(Smin,Pt,Gt,Gr,rcs,opFreq)
% RMAXDB  Max radar detection range (inputs in dB)
% 
%   [Rdb R]=rmaxdb(Smin,Pt,Gt,Gr,rcs,opFreq)
% 
%   OUTPUTS
%   Rdb = Detection range of receiver against given source [dB(m)]
%   R   = Detection range of receiver against given source [m]
% 
%   INPUTS
%   Smin   = Minimum sensitivity of the ES receiver.       [dBW]
%   Pt     = Transmitted power of the radar.               [dBW]
%   Gt     = Gain of the radar transmit antenna.           [dB]
%   Gr     = Gain of the radar receive antenna.            [dB]
%   rcs    = Radar cross section.                          [dB(m^2)]
%   opFreq = Operating frequency of the radar transmitter. [Hz]
% 
% -------------------------------------------------------------------------
%   OPTIONAL PARAMETERS
%   If using EIRP instead of Pt and Gt, consider the function as following:
% 
%   [Rdb R]=rmaxdb(Smin,EIRP,Gr,rcs,opFreq)
% 
%   OUTPUTS
%   Rdb = Detection range of receiver against given source [dB(m)]
%   R   = Detection range of receiver against given source [m]
% 
%   INPUTS
%   Smin   = Minimum sensitivity of the ES receiver.       [dBW]
%   EIRP   = Effective Isotropic Radiated Power. (source)  [dBW]
%   Gr     = Gain of the radar receive antenna.            [dB]
%   rcs    = Radar cross section.                          [dB(m^2)]
%   opFreq = Operating frequency of the radar transmitter. [Hz]
% 
%   Note: EIRP is the combination of the gain of the antenna and the power
%         transmitted.
% -------------------------------------------------------------------------
% 
%   AIM:
%   To determine the maximum detection range for a radar with a particular 
%   gain, sensitivity, transmitting power and operating frequency against 
%   a target with a specified radar cross section. The radar will have 
%   either a particular gain and transmitting power or alternatively an 
%   Effective Isotropic Radiating Power (EIRP). See note above for
%   definition of EIRP.
% 
%   ADDITIONAL INFORMATION:
%   If there is not a specified radar receive antenna gain, 30dB would be a
%   typical value that could be used.
%   For RCS, a typical value for a fighter aircraft is around 5dB.
% 
%   TECHNICAL BACKGROUND:
% 
% 
%   REFERENCES:
% TODO: tech back and ref. check typical rcs in addit info
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008

%   Copyright 2008


%% If input is Pt Gt
if nargin>5
    g=db2g(Gr);                             % Rx gain [ratio]
    Aeratio=ae(f2l(opFreq),g);              % Ae (effective antenna 
                                              % aperture)as a ratio
    Ae=g2db(Aeratio);                       % Ae in dB
    Rdb=(-Smin+Pt+Gt+rcs-2*spreaddb+Ae)/4;  % Max range [dB(m)]
    R=db2g(Rdb);                            % Max range [m]
    disp('rmaxdb using Pt Gt')
%% If input is EIRP    
else
    EIRP=Pt;                                % Initiate EIRP
    gr=Gt;                                  % Rx gain [dB]
    f=Ges;                                  % Operating frequency
    g=db2g(gr);                             % Rx gain [ratio]
    Aeratio=ae(f2l(f),g);                   % Ae [ratio]
    Ae=g2db(Aeratio);                       % Ae [dB]
    Rdb=(-Smin+EIRP+rcs-2*spreaddb+Ae)/4;   % max range [db(m)]
    R=db2g(Rdb);                            % max range [m]
    disp('rmaxdb using EIRP')
end