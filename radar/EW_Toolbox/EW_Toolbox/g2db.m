function db=g2db(gain)
% G2DB  Converts from ratio to decibels
% 
%   db=gb2db(gain)
% 
%   INPUTS
%   gain = linear ratio [1]
%   
%   OUTPUTS
%   db = Ratio in decibels (logarithmic) [dB]
% 
%   AIM:
%   To convert a unitless ratio to a ratio in decibels. Some may understand
%   this easier thinking of it as converting a linear number to a
%   logarithmic number.
% 
%   TECHNICAL BACKGROUND:
%   TODO: Airborne radar tech and ref
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008
% 
%   See also db2g

%   Copyright 2008

db=10*log10(gain);  % Value in decibels