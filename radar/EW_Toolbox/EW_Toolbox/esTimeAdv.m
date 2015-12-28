function undetectedTime=esTimeAdv(rxVel,rdrVel,range,angle)
% ESTIMEADV Time before detection by sensed radar
% 
%   undetectedTime=esTimeAdv(rxVel,rdrVel,range,angle)
% 
%   OUTPUT
%   undetectedTime = Time before radar will detect receiver platform [s]
% 
%   INPUT
%   rxVel  = Velocity of ES system platform [kts]
%   rdrVel = Velocity of RDR platform       [kts]
%   range  = ES advantage over the radar (max range or ES advantage can be
%            found by using esAdv function) [m]
%   angle  = angle from head on, where 0 degrees is head on   [degrees]
%            (optional parameter - assumed 0 degrees if not supplied)
%
%   AIM: 
%   To determine the amount of time the platform operating the ES receiver
%   has from detection of the radar transmitting source until detected by
%   that source.
% 
%   TECHNICAL BACKGROUND: 
% 
% 
%   REFERENCES: GIANCOLI p.57
%   Name, Title, Publisher, Year
% 
%   See also ESVRDR, VC, 
% 
%   AUTHOR: Jason MOYLE
%   DATE: March 2008

%   Copyright 2008

% TODO: tech back and ref

%% Check if ES system is detected
if range<=0
    undetectedTime=0;       % Already detected
    return
end
if nargin<4
    angle=0;
end
%% Initiate Variables
vc=vckt(rdrVel,rxVel,angle);    % Closing velocity [m/s]
r=range;                        % ES advantage range

%% Calculate time
undetectedTime=r/vc;