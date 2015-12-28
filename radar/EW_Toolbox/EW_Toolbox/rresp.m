function tau=rresp(sep)
% RRESP Range Resolution - pulse width (pulsed radar)
% 
%   tau=rresp(sep)
% 
%   sep = max dectectable separation of targets [m]
%   tau = width of pulse [s]
% 
%   AIM: To determine the pulse width needed to achieve a desired range
%   resolution.
% 
%   TECHNICAL BACKGROUND: A critical factor of pulsed radar performance is
%   the width of the pulse. Blind range is the term given to ranges where
%   targets are not able to be detected by the radar. The reason they
%   cannot be detected is because they are either too close or too far away
%   from the radar therefore returning RF energy during the window where
%   the radar is still transmitting. Range resolution is closely related to
%   blind range and is described as the ability of a radar to distinguish
%   or resolve two targets that are close together in range. Targets
%   separated by the range resolution or greater can be resolved.
%   Range Resolution = speed of light * pulse width / 2
%   By knowing the range resolution required we can then work out the
%   required pulse width by rearranging the above equation.
% 
%   REFERENCES: "Radar Fundamentals", Ian Faulconbridge, Argos Press, 2002

% c=3e8;  % Speed of light %now use speed of light function
tau = 2*sep/c;  % range resolution