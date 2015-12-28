function [angleDeg angleRad]=angleSearch(inputMatrix,tolerance)
% ANGLESEARCH Finds closest number within tolerance between rows
% 
%   [angleDeg angleRad]=angleSearch(inputMatrix,tolerance)
%   
%   OUTPUTS
%   angleDeg = angle as a result of closest match between arrays [degrees]
%   angleRad = angle as a result of closest match between arrays [radians]
% 
%   INPUTS
%   inputMatrix = n x m matrix of possible angles [degrees]
%                 where both n and m must be greater than 1
%   tolerance   = how close the match should be.  [1]
%                 If no tolerance is set, function will revert to a default
%                 value of 1.   
%   
%   AIM: 
%   To find the closest matching value between rows. To be used with
%   interferometer function.
% 
%   TECHNICAL BACKGROUND:
%   In an interferometer system, a longer baseline will provide a more
%   accurate angular result. However this comes at the cost of ambiguities.
%   Once an antenna baseline is increased to more than half a wavelength,
%   ambiguities will arise. A well designed system will result in
%   ambiguities being reduced or eliminated by having several well placed
%   antennas. Therefore there will only be one solution between several
%   pairs. This function looks for that one solution.
%   The function uses a search algorithm to compare values in rows, with
%   aim to find at least two values within the tolerance between the rows.
%   Values within tolerance between the rows represent the actual angle.
% 
%   REFERENCE:
%   Benson, Frater, Ryan, TACTIACL ELECTRONIC WARFARE, Argoss Press, 2007,
%   p.218.
%   Adamy, INTRO TO EW MODELLING AND SIMULATION, Artech house, 2003, p.134
% 
%   
%   AUTHOUR: Jason Moyle
%   DATE: September 2008
% 
%   See also AOAINTER

%   Copyright 2008 by Jason Moyle

if nargin<2
    tol = 1;            % search tolerance
else
    tol=tolerance;
end
diff=tol+1;             % initiate variable for difference between like numbers
closestMatch=[];        % initiate variable
a=inputMatrix;          % initiate matrix
[rows,cols]=size(a);    % find number or rows and colums

for r=1:rows-1          % loop for all but last row, it will already be checked
    refarray=a(r,:);       % separate reference row from matrix
    im=imag(refarray);     % find index of imaginary numbers
    for checkrow=r+1:rows           % check all following rows
        checkarray=a(checkrow,:);   % separate row to check
        for c=1:cols       % check all reference colums
            if im(c)       % ignore if the reference is imaginary
                continue
            end
            for checkc=1:cols       % check all colums in next row
                if imag(checkarray(checkc))     % ignore imaginary numbers in check row
                    continue
                end
                %-- Check to see if the numbers are close within tolerance
                if checkarray(checkc)>=refarray(c)-tol&&checkarray(checkc)<=refarray(c)+tol
                    %-- See if it is the closest match
                    if abs(checkarray(checkc)-refarray(c))<diff
                        diff=abs(checkarray(checkc)-refarray(c));
                        closestMatch = checkarray(checkc);
                    end
                    
                end
            end
        end
    end
angleDeg=closestMatch;
angleRad=d2r(angleDeg);
end