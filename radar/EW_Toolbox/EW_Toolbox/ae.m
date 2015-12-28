function Ae=ae(lambda,G,eta)
% AE  Calculate Antenna Effective Apperture
% 
%   Ae=ae(lambda,G,eta)
%   
%   OUTPUT
%   Ae = Effective apperture [m^2]
% 
%   INPUTS
%   lambda = wavelength of electromagnetic energy [m]
%   G      = Gain of the antenna [ratio]
%   eta    = antenna efficiency [%]
% 
%   OPTIONAL PARAMETERS
%   eta   
%   If eta is not supplied, the antenna is assumed to be 100% efficient.
% 
%   EXAMPLE
%   For an antenna with 1000 times gain operating at 10GHz and having an
%   efficiency of 65%
%   effapp = ae(0.03,1000,65)
%   effapp = 
%           0.1102
% 
%   AIM: 
%   To calculate the effective apperture of an Antenna 
% 
%   ADDITIONAL INFORMATION
%   * Once you have the antenna effective apperture, Ae, you can then use 
%   D=2*sqrt(Ae/pi) to find the diameter.
%   * If the antenna efficiency is given as a number less than one it is
%   likely to be a ratio instead of a percentage. Multiply this number by
%   100 to input as a percentage. Eg. 0.7*100=70%
% 
% 
%   TECHNICAL BACKGROUND:
% 
%   REFERENCES:
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008
% TODO: Tech and ref
%   See also AEG       

%   Copyright 2008 by Jason Moyle

% Check if eta is supplied, if not, assign 100% efficiency
if nargin<3
    eta=100;
    disp('Assumed 100% antenna efficiency when using "ae".')
end
% Calculate Effective apperture
Ae=lambda^2*G/4/pi/eta*100;
