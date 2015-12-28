function range = rangedb(S, Pt, rcs, Gt, Gr, opFreq)
% RANGEDB Returns the maximum two way radar range
% 
%   rangedb(S, Pt, rcs, Gt, Gr, opFreq)
% 
% 
%   range = maximum radar range [dB(m)]
% 
%   S = received signal power [dBW]
%   Pt = power transmitted [dBW]
%   rcs = Radar Cross Section [dB(m^2)]
%   Gt = Gain of transmit antenna
%   Gr = Gain of receive antenna
%   opFreq = operating frequency [Hz] 
% 
%   AIM:
% 
%   TECHNICAL BACKGROUND:
% 
%   REFERENCES:
% 
%   AUTHOR: Jason Moyle
%   DATE: September 2008
% 
%   TODO: Complete help file

%% Check inputs
% Not enough inputs
if nargin<5
    error('Not enough input arguments supplied to "rangedb" See help file')
end
freq=1;
% No Gr included
if nargin<6
    freq=0;
end

%% Calculate range if frequency is supplied
if freq==1;
    l=f2l(opFreq);      % wavelength
    grx=db2g(Gr);       % rx gain as ratio
    aeff=ae(l,grx);     % effective apperture
    aeffdb=g2db(aeff);  % effective apperture in dB
    range = (-S+Pt+Gt-2*spreaddb+rcs+aeffdb)/4;
else    
%% Calculate range if frequency is NOT supplied
    range = (-S+Pt+Gt-2*spreaddb+rcs+Gr)/4;
end