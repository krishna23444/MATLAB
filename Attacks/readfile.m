function [ I, G, P, N, LI, R, P1, V1, P2, V2, P3, V3, P4, V4, P5, V5 , P6, V6] = readfile(filename)
% readfile Read file for checkmark html pages generation.
% readfile(filename) sends back in I, G, etc. all data obtained
% from the text data file 'filename'. The path where the data file 
% searched is given by the global DATA_INPUT_PATH.
%
% The return data must be read as follows:
%   I   The image being attacked.
%   G   The group to which the attack belongs
%   P   The weight
%   N  
%   LI  A little image
%   R   The result of the attack.
%   P1  First Parameter name
%   V2  First Parameter value (only the first parameter has character value)
%   ... Other parameters
%
% Later, output arguments can be added in order to return the parameters,
% and the values contained in the data file.
%
% Written by Vladimir Calderon
%
% Copyright (c) 2001, Shelby Pereira, University of Geneva
% 
%  Permission to use, copy, modify, and distribute this software and its
%  documentation for any non-commercial purpose and without fee is hereby
%  granted (GPL), provided that the above copyright notice appear in all
%  copies and that both that copyright notice and this permission notice
% appear in supporting documentation. This software is provided "as is" 
% without express or implied warranty. The authors shall not be held
% liable in any event for incidental or consequential damages in
% connection with, or arising out of, the furnishing, performance, or
% use of this program.
% 
% If you use the Checkmark software package for your research, please cite:
%
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madueño, Stéphane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001.
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
global HTML_OUTPUT_PATH
global INCLUDE_HEADER_PATH


if (nargout < 6) 
    error('You must provide at least 6 return arguments');
end
if (mod(nargout,2) ~= 0)
    error('Parameters in return (args 7 through ...) come in pairs.');
end
char(filename)
[ I G P N LI R1 P1 V1 P2 V2 P3 V3 P4 V4 P5 V5 P6 V6] = textread(char(filename),'%s%s%f%d%s%s%s%c%s%f%s%f%s%f%s%f%s%f%*[^\n]');

% transform the noresults into zeros
R=zeros(length(R1),1);
for i=1:length(R1)
  tmp=str2num(char(R1(i)));
  if isempty(tmp)
    disp(['warning!! no result for line # ' num2str(i) ' for the file' char(filename) ' setting result to 0 (no watermark found)'])
    R(i)=0;
  else
    R(i)=tmp;
  end
end
