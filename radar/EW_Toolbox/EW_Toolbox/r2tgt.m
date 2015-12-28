function r=r2tgt(prt)
% R2TGT Range to target (pulsed radar)
% 
%   r = r2tgt(prt)
% 
%   r = range to target [m]
%   prt = pulse return time [s]
% 
%   AIM: To determine the range of a target based on the time it takes for
%   a transmitted pulse to return to the transmitting pulsed radar.
% 
%   TECHNICAL BACKGROUND: The most fundamental measurement a radar makes is
%   the distance or range to a target. This is done by the radar system
%   transmitting a pulse of RF energy and timing how long it takes for that
%   energy to return. It this example it is assumed that the time it takes 
%   for the pulse to the target is the same as the time it takes to return 
%   from the target.
%   The distance travelled then is 2R (R to the target then R back). The
%   time it takes for the pulse of RF energy to travel to the target and
%   back is T seconds and the speed it travells at is c (speed of light).
%   Therefore the range can be calculated by R=c*T/2.
% 
%   REFERENCES: "Radar Fundamentals", Ian Faulconbridge, Argos Press, 2002
% 
%   See also T2TGTR

% c=3e8;  % Speed of light %now use speed of light function
t=prt;  % Time for pulse to return
r=c*t/2; % range to target