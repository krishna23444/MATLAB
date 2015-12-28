function degrees=r2d(radians)
% R2D  Converts radians to degrees 
% 
%   degrees=r2d(radians)
% 
%   INPUT
%   radians = Angle to be converted [radians]
% 
%   OUTPUT
%   degrees = Converted angle [degrees]
%   
%   AIM:
%   To convert an angle from to radians degrees.
% 
%   TECHNICAL BACKGROUND:
%   The radian is the angle subtended at the center of a circle by an arc
%   that is equal in length to the radius of the circle.
%   The degree is a measurement of plane angle representing 1/360 of a full
%   rotation.
%   There is pi radians in 180 degrees.
% 
%   EXAMPLE
%   pi radians = 180 degrees
%   therefore
%   1 degree = pi/180 radians
%   and
%   x degrees = x radians/(pi/180)
%             = x radians/pi*180
% 
%   REFERENCE:
%   http://en.wikipedia.org/wiki/Radian
%   http://en.wikipedia.org/wiki/Degree_(angle)
% 
% TODO: Find reference from maths book or si unit.
% 
%   Author: Jason Moyle
%   Date: September 2008
% 
%   See also D2R

%   Copyright 2008 by Jason Moyle

r=radians;
degrees = r/pi*180;   % Angle in degrees