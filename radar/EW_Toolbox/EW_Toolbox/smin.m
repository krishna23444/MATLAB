function sMin=smin(bandWidth, temperature, SNR)
% SMIN Minimum Sensitivity
% 
%   smin=(bandWidth, temperature, SNR)
% 
%   returns Smin [dBm]
%       30 dBm = 0 dBW
%   
%   bandwidth = receiver bandwidth [Hz]
%   temperature = Effective noise temperature [K]
%   SNR = Detection threshold [dB]


% n=noise(bandWidth,temperature)
% ndb=g2db(n)
sMinDbw=g2db(noise(bandWidth,temperature))+SNR;
sMin=sMinDbw+30;