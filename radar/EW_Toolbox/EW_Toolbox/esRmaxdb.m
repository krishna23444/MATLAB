function [Rdb R]=esRmaxdb(Smin,Pt,Gt,Ges,opFreq)
% ESRMAXDB  Max ES receiver detection range (inputs in dB)
% 
%   [Rdb R]=esRmaxdb(Smin,Pt,Gt,Ges,opFreq)
% 
%   OUTPUTS
%   Rdb = Detection range of receiver against given source [dB(m)]
%   R   = Detection range of receiver against given source [m]
% 
%   INPUTS
%   Smin   = Minimum sensitivity of the ES receiver.       [dBW]
%   Pt     = Transmitted power of the radar.               [dBW]
%   Gt     = Gain of the transmitter (source) antenna.     [dB]
%   Ges    = Gain of the ES system (receiver) antenna.     [dB]
%   opFreq = Operating frequency of the radar transmitter. [Hz]
% 
% -------------------------------------------------------------------------
%   OPTIONAL PARAMETERS
%   If using EIRP instead of Pt and Gt, consider the function as following:
% 
%   [Rdb R]=esRmaxdb(Smin,EIRP,Ges,opFreq)
% 
%   OUTPUTS
%   Rdb = Detection range of receiver against given source [dB(m)]
%   R   = Detection range of receiver against given source [m]
% 
%   INPUTS
%   Smin   = Minimum sensitivity of the ES receiver.       [dBW]
%   EIRP   = Effective Isotropic Radiated Power. (source)  [dBW]
%   Ges    = Gain of the ES system (receiver) antenna.     [dB]
%   opFreq = Operating frequency of the radar transmitter. [Hz]
% 
%   Note: EIRP is the combination of the gain of the antenna and the power
%         transmitted.
% -------------------------------------------------------------------------
% 
%   AIM:
%   To determine the maximum detection range for an Electronic Support
%   receiver with a particular gain and sensitivity, against a transmitting
%   radar at a specified operating frequency. The radar will have either a
%   particular gain and transmitting power or alternatively an Effective
%   Isotropic Radiating Power (EIRP).
% 
%   TECHNICAL BACKGROUND:
% 
% 
%   REFERENCES:
% TODO: tech back and ref.
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008

%   Copyright 2008


%% If input is Pt Gt
if nargin>4
    g=db2g(Ges);
    Aeratio=ae(f2l(opFreq),g);
    Ae=g2db(Aeratio);
    Rdb=(-Smin+Pt+Gt-spreaddb+Ae)/2;
    R=db2g(Rdb);
    disp('esRmaxdb using Pt Gt')
%% If input is EIRP    
else
    EIRP=Pt;
    ges=Gt;
    f=Ges;
    g=db2g(ges);
    Aeratio=ae(f2l(f),g);
    Ae=g2db(Aeratio);
    Rdb=(-Smin+EIRP-spreaddb+Ae)/2;
    R=db2g(Rdb);
    disp('esRmaxdb using EIRP')
end