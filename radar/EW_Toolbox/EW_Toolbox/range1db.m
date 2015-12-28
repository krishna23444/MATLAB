function range = range1db(S, Pt, Gt, Gr, opFreq)
% RANGE1DB Returns the maximum one way radar range (I/O in dB)
% 
%   rangedb(S, Pt, Gt, Gr, opFreq)
% 
% 
%   range = maximum radar range [dB(m)]
% 
%   S = received signal power [dBW]
%   Pt = power transmitted [dBW]
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
if nargin<4
    error('Not enough input arguments supplied to "range1db" See help file')
end
freq=1;
% No Gr included
if nargin<5
    freq=0;
end

%% Calculate range if frequency is supplied
if freq==1;
    l=f2l(opFreq);      % wavelength
    grx=db2g(Gr);       % rx gain as ratio
    aeff=ae(l,grx);     % effective apperture
    aeffdb=g2db(aeff);  % effective apperture in dB
    range = (-S+Pt+Gt-spreaddb+aeffdb)/2;
else    
%% Calculate range if frequency is NOT supplied
    range = (-S+Pt+Gt-spreaddb+Gr)/2;
end