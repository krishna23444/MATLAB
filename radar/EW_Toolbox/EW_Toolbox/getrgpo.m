function offset=getrgpo(time,rgpoMatrix)
% GETRGPO Gets the false target offset at a particular time.
% 
%   offset=getrgpo(time,rgpoMatrix)
%   
%   offset = offset of false target from real target
%   time = time at which to find offset
%   rgpoMatrix = matrix formed from rgpo(t,dr)
% 
%   Author: Jason Moyle
%   Date: May 2008
% 
%   See also RGPO

t=rgpoMatrix(1,:)
dr=rgpoMatrix(2,:)
offset=interp1(t,dr,time)
end