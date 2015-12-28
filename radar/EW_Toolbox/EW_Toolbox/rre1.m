function pr=rre1(Pt, R, opFreq,Gt,Gr)
% RRE1  One way Radar Range Equation - power at receiver
% 
%   rre1(Pt, R, opFreq,Gt,Gr)
% 
%   R = [m]
%   Pt = [W]
%   Gt/Gr = [ratio]
%   Pr is returned in Watts
% 
%   AIM: To determine the power received at a range from a transmitting
%   source.
%   
%   Technical Background:

% nargin
if nargin==4
    Gr=Gt;  % Rx Ae gain assumed to be same as Tx Ae Gain
elseif nargin~=5
    error('Incorrect number of input arguments. Must have at least first 4 variables')
end
l=f2l(opFreq);
pr=Pt*Gt*Gr*l^2/(4*pi)^2./R.^2; % Power received [W]