function rreA
%RADAR_RANGE Shows effect of power vs range
% 
% radar_range
% 
% AIM: To display how the received power of an antenna is effected by
% range.
% 
% TECHNICAL BACKGROUND: GO INTO STUFF ABOUT THE RADAR RANGE EQUATION IE.
% POWER TX, PWR RX, RCS ETC. LOOK AT FAULCONBRIDGE AND EW INFO AGE.
% 
% REFERENCES:
% 
% FURTHER DEVELOPMENT: Could make this take in all variables. Then you
% could have another function that calls this one adjusting the variables
% each time. This could then be plotted to show differences, for example,
% when Ae is increased, when Pt is increased, etc.


%% VARIABLES

pt=1e6;     % Power transmitted [W]
R=linspace(0,5000,100);    % Range out to 5km [m]
Gt=4000;    % Antenna Tx Gain [ratio]
Gr=Gt;      % Antenna Rx Gain [ratio]
rcs=3;      % Radar cross section [m^2]
opFreq=3e6; % Radar operating frequency [Hz]

% Calculated variables
ae=Gr*f2l(opFreq)^2/4/pi;         % Effective Area of the Receive Antenna [m^2]

%% CALCULATIONS

%% Power density at the Target (isotropic)

pd=pt./(4*pi.*R.^2);   % Power density [W/m^2]

%% Power density at the Target (Antenna gain)

pdg=pd.*Gt;

%% Power density at the Receiver

pdr=pdg*rcs./(4*pi.*R.^2);

%% Power received

pr=pdr.*ae;

%% Plot

plot(10*log10(R),10.*log10(pr))

% %% Test other method
% 
% for i=1:1:length(R)
%     pd=pt/(4*pi*R(i)^2);   % Power density [W/m^2]
%     pdg=pd*Gt;
%     pdr=pdg*rcs/(4*pi*R(i)^2);
%     pr2(i)=pdr*ae;
% end
% hold on
% plot(R,pr2)
% 
% isequal(pr,pr2)