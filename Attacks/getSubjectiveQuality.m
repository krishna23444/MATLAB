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
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
function compressionquality=getSubjectiveQuality(P,val,type1)

if strcmp(type1,'J')==1
  if val>=85
    compressionquality=P.CompressionQualityVHigh;
  elseif val>=50
    compressionquality=P.CompressionQualityHigh;
  elseif val>=25
    compressionquality=P.CompressionQualityMedium;
  else
    compressionquality=P.CompressionQualityLow;
  end
elseif  strcmp(type1,'W')==1
  if val>=2
    compressionquality=P.CompressionQualityVHigh;
  elseif val>=1
    compressionquality=P.CompressionQualityHigh;
  elseif val>=0.4
    compressionquality=P.CompressionQualityMedium;
  else
    compressionquality=P.CompressionQualityLow;
  end
end
