function rgpoMatrix=rgpo(t,dr)
% RGPO Returns a rgpo matrix and performs a rgpo plot
% 
%   rgpoMatrix=rgpo(t,dr)
% 
%   rgpoMatrix = matrix of t and dr
%   t = time 
%   dr = offset of false target from real target
% 
%   Aim: Provide a matrix (to act as rgpo object) so further rgpo
%   operations can be performed.
% 
%   Technical Background:
% 
%   Author: Jason Moyle
%   Date: May 2008

% Check length of both inputs
% (maybe put a check here to orientate the maticies correctly)
if size(t)~=size(dr)
    disp('When using rgpo(t,dr), size of matrix t must be the same as'...
        ,'matrix dr')
end
tt=linspace(t(1),t(end),1000);
plot(tt,getrgpo(tt,[t; dr]))
title('VGPO')
xlabel('Time')
ylabel('Apparent Speed Increase')
rgpoMatrix=[t; dr];