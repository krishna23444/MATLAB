function G=aeg(Ae,lambda,eta)
% AEG  Calculate Antenna Gain
% 
%   G=aeg(Ae,lambda,eta)
%   
%   OUTPUT
%   G = Gain of the antenna [ratio]
% 
%   INPUTS
%   Ae     = Effective apperture    [m^2]
%   lambda = wavelength of electromagnetic energy [m]
%   eta    = antenna efficiency    [%]
% 
%   OPTIONAL PARAMETERS
%   eta
%   If eta is not supplied, the antenna is assumed to be 100% efficient.
% 
%   AIM: To calculate the gain of an Antenna 
% 
%   ADDITIONAL INFORMATION
%   * If you only have the antenna diameter, d, use Ae=pi*(d/2)^2
%   * If the antenna efficiency is given as a number less than one it is
%   likely to be a ratio instead of a percentage. Multiply this number by
%   100 to input as a percentage. Eg. 0.7*100=70%
% 
%   TECHNICAL BACKGROUND: 
% 
% 
%   REFERENCES:
% 
%   See also AE
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008
% TODO: tech back and ref

%   Copyright 2008 by Jason Moyle

% Check if eta is supplied, if not, assign 100% efficiency
if nargin<3
    eta=100;
    disp('Assumed 100% antenna efficiency when using "aeg".')
end
% Calculate Gain
G=4*pi*Ae*eta/100/lambda^2;
