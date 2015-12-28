function [TTI,tti]=tti(rxScanTime,txPulseWidth,rxPRI,ttiPercent)
% TTI Time to Intercept
% 
%   TTI=tti(rxScanTime,rxPulseWidth,rxPRI,ttiPercent)
% 
%   tti = time to intercept [s]
%   TTI = time to intercept at required percent [s]
%   rxScanTime = Receiver scan time [s]
%   txPulseWidth = Receiver pulse width [s]
%   rxPRI = Receiver pulse repetition interval [s]
%   ttiPercent = percent of time intercept is required [%]
% 
%   AIM: To find the time it takes for a pulsed receiver to intercept an in
%   band CW radar.
% 
%   TECHNICAL BACKGROUND:
% 
%   REFERENCES: Benson Frater Ryan, Tactical EW, Argoss Press, 2007
% 
%   AUTHOR: Jason MOYLE
%   DATE: April 2008

tti=rxScanTime; % Time to intercept based on half the scan time needs to
                %  coincide with the emitter
                
% Assume tx and rx have independant timing

pd=txPulseWidth/rxScanTime; % Probability of detection

TTI=rxPRI*(log10(ttiPercent/100)/log10(1-pd)); % TTI x percent of the time