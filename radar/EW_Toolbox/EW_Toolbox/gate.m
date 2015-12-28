function [Rgate, numGates, Ruamb]=gate(PRI, tau)
% GATE Range Gate Information (pulsed radar)
% 
%   [Rgate, numGates, mur]=gate(PRI, tau)
% 
%   Rgate = width of range gate [m]
%   numGates = maximum number of gates [rounded down integer]
%   Ruamb = max unambiguous range [m]
%   PRI = pulse repetition interval [s]
%   tau = pulse width
% 
%   AIM: To provide range gate information based on the PRI and pulse
%   width.
% 
%   TECHNICAL BACKGROUND: Range gates are used to store radar returns
%   between successive pulses. The information stored is used by the
%   processor to reduce ambiguous returns. Range gates are discrete slots 
%   in time, therefore we are able to work out a range for each gate (from 
%   the range resolution, determined by the pulse width) and how many gates
%   can be employed for a particular MUR (determined by PRI).
% 
%   REFERENCES: "Radar Fundamentals", Ian Faulconbridge, Argos Press, 2002

Rgate = rres(tau);
Ruamb = mur(PRI);
numGates = floor(Ruamb/Rgate);