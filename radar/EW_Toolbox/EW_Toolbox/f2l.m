function lambda=f2l(freq)
%F2L Converts frequency to wavelength
% 
% lambda=f2l returns the wavelength in m for a given frequency in
% hertz.
% eg. 20GHz = 0.015m
% 
%   TECHNICAL BACKGROUND:
%   Wavelength is commonly used when doing calculations in the RF domain. In
%   the EW toolbox, wavelength is used in calculations such as antenna gain.
%   TERM: Wavelength
%   UNIT: m
%   SYMBOL: lambda
% 
%   REFERENCES:
% 
% 
%   See also L2F
% 
%   AUTHOUR: Jason Moyle
%   DATE: 2008
% 
%   Copyright 2008

%% Variables
% c=3e8;      % Speed of light % now calls c function
f=freq;      % Frequency to be converted

%% Calculation
lambda=c/f;
