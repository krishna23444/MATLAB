function kmperhr=kt2kmh(knots)
%KT2KMH Converts from knots to kilometres per second
% 
%   kmperhr=kt2kmh(knots)
% 
%   kmperhr = kilometres per hour [km/hr]
%   knots = nautical miles per hour [kts]
% 
%   AIM:
%   To convert nautical miles per hour or knots, which is commonly used as
%   an aeronautical speed reference, to kilometres per hour.
% 
%   TECHNICAL BACKGROUND:
%   1 international knot is defined as 1 nautical mile per hour which is
%   exactly equal to 1.852 kilometers per hour or 0.5144 metres per second.
%   
%   A knot is sometimes incorrectly refered to as the nautical mile. It is
%   a measure of speed, not distance.
%   
%   The abbreviation for a knot is kt.
% 
%   REFERENCE:
%   National Master Encyclopedia
%   http://www.nationmaster.com/encyclopedia/Knot-(speed)
%   
%   AUTHOR: Jason MOYLE
%   DATE: September 2008 
% 
%   See also KT2MS, KMH2MS.

kmperhr=knots*nm/1000;
