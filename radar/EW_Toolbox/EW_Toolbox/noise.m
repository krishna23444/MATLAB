function N=noise(bandwidth, temperature)
% NOISE External Noise
% 
%   N=noise(bandwidth, temperature)
% 
%   N = external noise [unit]
%   bandwidth = pulse bandwidth
% 
%   AIM: 
% 
%   TECHNICAL BACKGROUND: 
% 
%   REFERENCES: Name, Title, Publisher, Year
% 
% TODO: Help

k=1.38e-23;

N=k*temperature*bandwidth;