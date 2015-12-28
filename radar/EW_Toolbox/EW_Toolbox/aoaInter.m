function [angleDeg angleRad]=aoaInter(phaseAngle, distance, opFreq)
% AOAINTER  Interferometer based angle of arrival
% 
%   [angleDeg angleRad]=aoaInter(phaseAngle, distance, opFreq)
%   
%   OUTPUTS
%   angleDeg     = Calculated angle of arrival of the radar signal [degrees]
%   angleRadians = Calculated angle of arrival of the radar signal [radians]
% 
%   INPUTS
%   phaseAngle = phase difference of received signal between two antennas
%                [degrees]
%                this can be entered as an array if more than two antennas
%                eg. [193 87]
%   distance   = distance between antennas [m]
%                ensure this corresponds with the phase angle difference
%                eg. phi 1-2 = 193, dist 1-2 = 0.5m
%   opFreq     = operating frequency [Hz]
% 
%   EXAMPLE
%   Phase angle difference between antennas
%   phi 1-2 = 193
%   phi 1-3 = 87
%   Distance between antennas
%   1-2 = 0.5m
%   2-3 = 0.1m
%   Operating frequency is 3 GHz
%   myArrivalAngle = aoaInter([193 87],[0.5 0.6],3e9)
% 
%   AIM:
%   To determine the angle of arrival of a radar signal
% 
%   TECHNICAL BACKGROUND:
%   An interferometer is a system which determines the angle of arrival of
%   a signal by comparing the phase of the signal when it arrives. The
%   phase is measured over an array of irregularly spaced linearly arranged
%   antenna pairs. The spacing of these antenna pairs is crucial to achieve
%   an accurate system.
%   In an interferometer system, a longer baseline will provide a more
%   accurate angular result. However this comes at the cost of ambiguities.
%   Once an antenna baseline is increased to more than half a wavelength,
%   ambiguities will arise. A well designed system will result in
%   ambiguities being reduced or eliminated by having several well placed
%   antennas. Therefore there will only be one solution between several
%   pairs.
%   Adv: high accuracy from short baseline, works against pulsed and CW
%   Disadv: cost, multiple antennas, receiver phase matchiing requirements 
% 
%   REFERENCE:
%   Benson, Frater, Ryan, TACTIACL ELECTRONIC WARFARE, Argoss Press, 2007,
%   pp.218,219.
%   Adamy, INTRO TO EW MODELLING AND SIMULATION, Artech house, 2003, p.134
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008 
% 
%   See also ANGLESEARCH, AOAERR

%   Copyright 2008

%% Initiate variables
anglePhi=d2r(phaseAngle);   % Convert angles to radians
l=f2l(opFreq);              % Wavelength
d=distance;                 % Distance between antennas

%% Calculate possible valid angles
for i=1:length(anglePhi)
    phi=anglePhi(i);
    D=d(i);
%     fprintf('Results for angle %.0d',i)
    clear theta;
    for n=0:5
        theta(n+1)=asind((n+phi/2/pi)*l/D);
    end
    aoa(i,:)=theta;           % possible aoa for each set of antennas
end

%% Search for angle of arrival
angleDeg = angleSearch(aoa);
angleRad = d2r(angleDeg);