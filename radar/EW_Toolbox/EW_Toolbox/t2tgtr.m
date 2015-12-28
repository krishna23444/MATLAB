function T=t2tgtr(R)
% T2TGTR Time to target and return (pulsed radar)
% 
%   T = t2tgtr(R)
% 
%   R = range to target [m]
%   T = Time for pulse to travel to target and return [s]
% 
%   AIM: To determine the time it takes for a transmitted pulse to reach a
%   target and return to the transmitting pulsed radar.
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
%   If the range is known the time can be calculated by T=2R/c
% 
%   REFERENCES: "Radar Fundamentals", Ian Faulconbridge, Argos Press, 2002

% c=3e8;  % Speed of light %now use speed of light function
T=2*R/c; % range to target