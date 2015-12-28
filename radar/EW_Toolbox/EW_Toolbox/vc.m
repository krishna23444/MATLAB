function closingVel=vc(targetVel,myVel,angle)
% VC Converts two velocities in m/s and at an angle to a closing velocity in m/s
% 
%   closingVel=vc(targetVel,myVel)
% 
%   closingVel = closing velocity of two objects [m/s]
% 
%   targetVel = target velocity [m/s]
%   myVel = velocity of reference object [m/s]
%   angle = angle from head on, where 0 degrees is head on [degrees]
%           (optional parameter - assumed 0 degrees if not supplied)
% 
% 
%   AIM: 
% 
% 
%   TECHNICAL BACKGROUND: Assumes both aircraft are travelling toward each
%   other.
% 
%   REFERENCES: GIANCOLI p.57
%   Name, Title, Publisher, Year
% 
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008
% 
%   Copyright 2008
% 
% TODO: Complete help. Extension - Vc for aircraft at angle, not head on.

if nargin<3
    theta=0;
else
    theta=angle;
end
v1=targetVel;
v2=myVel;

v=v1+v2;
vc=v*cosd(theta);
closingVel=vc;