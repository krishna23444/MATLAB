function [errorDeg, errorRad]=aoaerr(angle, phaseError, baseline, opFreq)
% AOAERR Calculates interferometer angle error
% 
%   error=aoaerr(angle, phaseError, baseline, opFreq)
% 
%   OUTPUTS
%   errorDeg = angle error [degrees]
%   errorRad = angle error [radians]
% 
%   INPUTS
%   angle      = angle of arrival of radar signal [degrees]
%                accepts an array of angles
%   phaseError = phase measurement error [degrees]
%   baseline   = baseline (separation antennas) of interferometer [m]
%   opFreq     = received signal operating frequency [Hz]
% 
%   AIM:
%   To determine the angle error of a signal arriving at a particular
%   angle.
% 
%   TECHNICAL BACKGROUND:
%   TODO: Tech back
% 
%   REFERENCE:
%   Benson, Frater, Ryan, TACTIACL ELECTRONIC WARFARE, Argoss Press, 2007,
%   p.218
%   Schleher, ELECTRONIC WARFARE IN THE INFORMATION AGE, Artech house,
%   1999, p.381
% 
%   See also AOAINTER
% 
%   AUTHOR: Jason Moyle
%   DATE: September 2008

%   Copyright 2008

%% Initiate variables
dphi=d2r(phaseError);       % Convert phase error to radians
theta=d2r(angle);           % Convert arrival angle to radians
d=baseline;                 % Baseline
l=f2l(opFreq);              % Wavelength of opFreq

%% Calculate error
dtheta=l/2/pi/d./cos(theta)*dphi;
errorRad=dtheta;
errorDeg=r2d(dtheta);          % Convert angle error to degrees