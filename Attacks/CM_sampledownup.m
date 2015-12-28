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
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
% P.param1 is the downsampling factor
% P.param2 is the upsampling factor

function imout=CM_sampledownup(P,imin)

% check if the final size should be the original size
% this check is necessary to avoid situations in which we would like the final
% image to be the same as the original.  Unfortunately this may not be the case
% because of rounding errors.
val=P.param1*P.param2;
if (abs(val-1)<0.005)  % the final size should be the same as the original
  [m,n]=size(imin);
  im1=imresize(imin,P.param1);
  imout=imresize(im1,[m,n]);
else % the final size is not the same as the original
  im1=imresize(imin,P.param1);
  imout=imresize(im1,P.param2);
end
