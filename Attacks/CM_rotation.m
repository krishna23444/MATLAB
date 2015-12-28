% function imout=CM_rotation(imin,ang1)
% performs a clockwise rotation at an angle ang1 and then crops out the central
% ang1 is in degrees
% interpolation is bicubic

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
% P.param1 is the angle of rotation in degrees

function imout=CM_rotation(P,imin)
ang1=P.param1;
imr=imrotate(imin,-ang1,'bicubic');

% find the midpoint of the new image
[m1,n1,o]=size(imr);
midx=floor(n1/2)+1;
midy=floor(m1/2)+1;



% calculate the size to crop out from the center
[m,n,o]=size(imin);a=max([m n]);b=min([m n]);
radang=(pi/180)*ang1;
scale1=min([abs(b/((a*sin(abs(radang)))+b * cos(abs(radang)))), abs(b/((a*sin(abs(radang)))-b * cos(abs(radang))))]);

newszx=round(n*scale1);
newszy=round(m*scale1);

px1=floor(midx-newszx/2);
py1=floor(midy-newszy/2);

imout=imcrop(imr,[px1 py1 newszx newszy]);


