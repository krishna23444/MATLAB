function [errorDegrees, errorRadians]=tdoaerr(angle, deltaTimeErr, baseline)
% TDOAERR Time difference of arrival angular error
% 
%   [errorDegrees, errorRadians]=tdoaerr(angle, deltaTime, baseline)
% 
%   errorDegrees = angular error of TDOA based on time, baseline and 
%                  received angle [degrees]
%   errorRadians = as above however answer in radians [radians]
% 
%   angle = angle of arrival of radar signal [degrees]
%           accepts an array of angles
%   deltaTimeErr = timing error of the system [s]
%   baseline = distance between receiving antennas [m]
% 
%   AIM: 
% 
% 
%   TECHNICAL BACKGROUND: 
% 
% 
%   REFERENCES:
% 
% 
%   See also TDOA
% 
%   AUTHOUR: Jason Moyle
%   DATE: September 2008
% 
%   Copyright 2008

%% Initiate variables
theta=d2r(angle);
d=baseline;
dt=deltaTimeErr;

%% Calculate error
errorRadians=c*dt/d./cos(theta);
errorDegrees=r2d(errorRadians);