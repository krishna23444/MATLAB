function ms=kmh2ms(kmPerHr)
% KMH2MS Converts from kilometres per hour to metres per second
% 
%   ms=kmh2ms(kmPerHr)
% 
%   ms = metres per second [m/s]
%   kmPerHr = kilometres per hour [km/hr]
% 
%   AIM:
%   To convert km/hr to m/s
% 
%   TECHNICAL BACKGROUND:
%   Simply uses the fact that there is 1000 metres in a kilometre and there
%   is 3600 seconds in an hour.
% 
%   REFERENCE:
%   Nil
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008
% 
%   See also KT2KMH, KT2MS.

ms=kmPerHr*1000/3600;
