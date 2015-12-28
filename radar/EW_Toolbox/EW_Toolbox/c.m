function lightSpeed=c()
% C  Speed of light
% 
%   lightSpeed=c()
% 
%   OUTPUT
%   lightSpeed = Speed of light [m/s]
%  
%   INPUT
%   Nil
% 
%   AIM: 
%   To provides the exact value for the speed of light. Effectively this
%   function acts as a global variable and can be called in a function by
%   simply entering 'c'. The advantage of being a function on its own is
%   that it does not have to be initiated before using any other function.
% 
%   TECHNICAL BACKGROUND:
%   Recommended values for the speed of light by the 1975 General
%   Conference on Weights and Measures, the CGPM, is 299,792,458 metres per
%   second. It is derived from the length of the metre, which is the length
%   light travels in 1/299,792,458 of a second.
%   
% 
%   REFERENCES: 
%   The International Standard of Units (SI), BIPM, 8th edition, 2006
% 
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008

%   Copyright 2008 by Jason Moyle

lightSpeed=299792458;   % Recommended speed of light