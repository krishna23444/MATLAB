function rgpoTest
% RGPOTEST  Supplies data to rgpo function
% 
%   Supplies data to rgpo function.
% 
%   Author: Jason Moyle
%   Date: May 2008

t=1:1:10;
dr=[0 0 30 60 90 120 150 180 200 200];
rgpoMatrix = rgpo(t,dr);
getrgpo(2.5,rgpoMatrix)