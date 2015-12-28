function rcscd=rcsChaff(frequency)
% RCSCHAFF Maximum radar cross section of a single chaff dipole
% 
%   rcscd=rcsChaff(wavelength)
% 
%   rcscd = Maximum RCS of a chaff dipole [m^2]
%   frequency = Operating frequency of targeting radar [Hz]
% 
%   AIM:
%   To find the maximum radar cross section (RCS) of a single chaff dipole.
% 
%   TECHNICAL BACKGROUND:
%   Chaff is made up of small aluminium strips. There is a coating on these
%   strips which makes the chaff strip conductive. An ideally orientated
%   chaff dipole, which is usually half the length of the targeting radar's
%   wavelength, has a RCS approximately equal to 0.86 x wavelength^2.
% 
%   REFERENCES:
%   Benson, Ryan, Frater, "Tactical Electronic Warfare", Argoss Press, 2007.
% 
%   AUTHOR: Jason MOYLE
%   DATE: September 2008

rcscd=0.86*f2l(frequency)^2;