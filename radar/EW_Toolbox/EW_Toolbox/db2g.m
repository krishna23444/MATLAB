function gain=db2g(db)
% DB2G Converts from decibels to ratio
% 
%   gain=db2g(db)
%   
%   OUTPUTS
%   gain = linear ratio [1]
% 
%   INPUTS
%   db = Ratio in decibels (logarithmic) [dB]
% 
%   AIM:
%   To convert a ratio in decibels to a unitless ratio. Some may understand
%   this easier thinking of it as converting a logarithmic number to a
%   linear number.
% 
%   TECHNICAL BACKGROUND:
%   TODO: Airborne radar tech and ref
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008
% 
%   See also g2db

%   Copyright 2008

gain=10.^(db/10);    % Value as ratio