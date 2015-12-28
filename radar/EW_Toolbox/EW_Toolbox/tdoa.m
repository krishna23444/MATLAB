function [angleDeg,errorDeg,angleRad,errorRad]=tdoa(deltaTime,baseline,timingErr)
% TDOA Time dirrerence of arrival
% 
%   [angleDeg,errorDeg,angleRad,errorRad]=tdoa(deltaTime,baseline)
% 
%   angleDeg = calculated angle of arrival [degrees]
%   errorDeg = angular error of TDOA based on time, baseline and 
%              received angle [degrees]
%   angleRad = calculated angle of arrival [radians]
%   errorRad = angular error of TDOA based on time, baseline and 
%              received angle [radians]
% 
%   deltaTime = time difference of arrival [s]
%   baseline = distance between receiving antennas [m]
%   timingErr = timing error [s] (optional parameter, assumed to be 1ns if
%               not included)
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
%   See also TDOAERR
% 
%   AUTHOUR: Jason Moyle
%   DATE: September 2008
% 
%   Copyright 2008

%% Initiate variables
if nargin<3
    dterr=1e-9;             % Timing error
else
    dterr=timingErr;
end
dt=deltaTime;               % Time difference of arrival
d=baseline;                 % Baseline of antennas

%% Calculate angle of arrival
angleDeg=asind(c.*dt/d);
angleRad=d2r(angleDeg);

%% Calculate error
[errorDeg errorRad]=tdoaerr(angleDeg,dterr,d);