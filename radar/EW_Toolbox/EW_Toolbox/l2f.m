function freq=l2f(wavelength)
%F2L Converts wavelength to frequency  
% 
%   freq=l2f(wavelength)
% 
%   freq = frequency [Hz]
% 
%   wavelength = wavelength to convert [m]
% 
%   TECHNICAL BACKGROUND:
%   Wavelength is commonly used when doing calculations in the RF domain. In
%   the EW toolbox, wavelength is used in calculations such as antenna gain.
%   Other times frequency is used, eg. when talking about radar operation.
%   The ability to convert between the two is very useful.
%   TERM: Frequency
%   UNIT: Hz
%   SYMBOL: f
% 
%   REFERENCES:
% 
% 
%   See also F2L
% 
%   AUTHOUR: Jason Moyle
%   DATE: September 2008
% 
%   Copyright 2008

%% Variables
l=wavelength;      % Frequency to be converted

%% Calculation
freq=c/l;