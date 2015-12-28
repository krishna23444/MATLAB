function PRI=muri(MUR)
% MURI Pulse Interval required to achieve given Maximum Unambiguous Range
% 
%   PRI=muri(R)
% 
%   PRI = pulse repetition interval [s]
%   MUR = max unambiguous range [m]
% 
%   AIM: To determine the pulse repetition interval required for a desired 
%   maximum unambiguous range.
% 
%   TECHNICAL BACKGROUND: Firstly it is important to note that Maximum
%   Unambiguous Range (MUR) differs from maximum radar range. Max radar
%   range is limited by the radar power and other constraints. MUR is due
%   to the pulse repetition interval or frequency. A pulsed radar needs to
%   allow enough time for the pulse to reach its target and return before
%   sending the next pulse. When a second pulse is sent before the first
%   one is returned, the radar can incorrectly interpret this lower
%   strength first pulse return as a close target return from the second 
%   pulse. This is known as an ambiguous return. Therefore the MUR is half
%   the distance (remember - to the target and back) a pulse can travel in
%   the interval between pulses.
%   MUR = c*PRI/2
%   This equation can be rearranged to find the PRI for a desired MUR.
% 
%   REFERENCES: "Radar Fundamentals", Ian Faulconbridge, Argos Press, 2002

% c=3e8;  % Speed of light %now use speed of light function
PRI=MUR*2/c;   % Required PRI