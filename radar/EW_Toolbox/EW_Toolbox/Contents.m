% Electronic Warfare Toolbox
% Version 0.1 22-Sep-2008
% 
% EW_TOOLBOX
%
% Files
%   ae              - Calculate Antenna Effective Apperture
%   aeg             - Calculate Antenna Gain
%   angleSearch     - Finds closest number within tolerance between rows
%   aoaerr          - Calculates interferometer angle error
%   aoaInter        - Interferometer based angle of arrival
%   c               - Speed of light
%   d2r             - Converts degrees to radians
%   datarate        - Data rate, bytes per minute storage
%   db2g            - Converts from decibels to ratio
%   esAdv           - Returns the maximum range an ES system has over a radar
%   esAdvGuiTest    - M-file for esAdvGuiTest.fig
%   esRmaxdb        - Max ES receiver detection range (inputs in dB)
%   esTimeAdv       - Time before detection by sensed radar
%   esVrdr          - Plots ES advantage and returns radar and ES parameters
%   esVrdrIncValues - Typical ES and RDR values produce plot of ES advantage
%   esVrdrNoPlot    - For use with GUI or programs which do not require a plot
%   f2l             - Converts frequency to wavelength
%   functionTesting - FUNCTIONTESTING
%   g2db            - Converts from ratio to decibels
%   gate            - Range Gate Information (pulsed radar)
%   getrgpo         - Gets the false target offset at a particular time.
%   heightf         - Required antenna height in feet to achieve a given radar horizon
%   heightm         - Required antenna height in metres to achieve a given radar horizon
%   kmh2ms          - Converts from kilometres per hour to metres per second
%   kt2kmh          - Converts from knots to kilometres per second
%   kt2ms           - Converts from knots to metres per second
%   l2f             - F2L Converts wavelength to frequency  
%   mur             - Maximum Unambiguous Range (pulsed radar)
%   muri            - Pulse Interval required to achieve given Maximum Unambiguous Range
%   nm              - Returns how many metres are in a nautical mile
%   noise           - External Noise
%   p2b             - Converts pulse width to band width
%   prf             - Pulse repetition Frequency (pulsed radar)
%   pri             - Pulse repetition Interval (pulsed radar)
%   r2d             - Converts radians to degrees 
%   r2tgt           - Range to target (pulsed radar)
%   range1db        - Returns the maximum one way radar range (I/O in dB)
%   rangedb         - Returns the maximum two way radar range
%   rcsChaff        - Maximum radar cross section of a single chaff dipole
%   rgpo            - Returns a rgpo matrix and performs a rgpo plot
%   rgpoAnim        - Visual animation of range gate pull out
%   rgpoDemo        - Visual demonstration of range gate pull out
%   rgpoTest        - Supplies data to rgpo function
%   rmaxdb          - Max radar detection range (inputs in dB)
%   rre             - Power at receiver using radar range equation
%   rre1            - One way Radar Range Equation - power at receiver
%   rre1eirpdb      - Power at receiver using decibal I/O and radar range equation
%   rreA            - RADAR_RANGE Shows effect of power vs range
%   rres            - Range Resolution - target seperation (pulsed radar)
%   rresp           - Range Resolution - pulse width (pulsed radar)
%   smin            - Minimum Sensitivity
%   spreaddb        - Spreading of sphere for spreading loss
%   t2tgtr          - Time to target and return (pulsed radar)
%   tdoa            - Time dirrerence of arrival
%   tdoaDemo        - shows the effects of different baselines and timimg errors vs aoa
%   tdoaerr         - Time difference of arrival angular error
%   tti             - Time to Intercept
%   vc              - Converts two velocities in m/s and at an angle to a closing velocity in m/s
%   vckt            - Converts two closing velocities in knots and at an angle to Vc in m/s
