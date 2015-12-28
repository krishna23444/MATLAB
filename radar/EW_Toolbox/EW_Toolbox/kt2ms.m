function mPerSec=kt2ms(knots)
%KT2MS Converts from knots to metres per second
% 
%   mPerSec=kt2km(knots)
% 
%   mPerSec = metres per second [m/s]
%   knots = nautical miles per hour [kts]
% 
%   AIM:
%   To convert nautical miles per hour or knots, which is commonly used as
%   an aeronautical measure of speed, to metres per second. Metres per
%   second is an SI unit which is commonly used by engineers.
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
%   See also KT2KMH, KMH2MS.

mPerSec=knots*nm/3600;
