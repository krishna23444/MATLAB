function radians=d2r(degrees)
% D2R  Converts degrees to radians
% 
%   radians=d2r(degrees)
% 
%   OUTPUT
%   radians = Converted angle [radians]
% 
%   INPUT
%   degrees = Angle to be converted [degrees]
% 
%   EXAMPLE
%   pi radians = 180 degrees
%   therefore
%   1 radian = 180/pi degrees
%   and
%   x radians = x degrees/(180/pi)
%             = x degrees/180*pi
% 
%   AIM:
%   To convert an angle from degrees to radians.
% 
%   TECHNICAL BACKGROUND:
%   The radian is the angle subtended at the center of a circle by an arc
%   that is equal in length to the radius of the circle.
%   The degree is a measurement of plane angle representing 1/360 of a full
%   rotation.
%   There is pi radians in 180 degrees.
% 
%   REFERENCE:
%   http://en.wikipedia.org/wiki/Radian
%   http://en.wikipedia.org/wiki/Degree_(angle)
% 
% TODO: Find reference from maths book or si unit.
% 
%   Author: Jason Moyle
%   Date: June 2008
% 
%   See also R2D

%   Copyright 2008 by Jason Moyle

d=degrees;

radians = d*pi/180;   % Angle in radians