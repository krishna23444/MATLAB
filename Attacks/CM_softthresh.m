% Copyright (c) 2001, Sviatoslav Voloshynovskiy, Shelby Pereira, University of Geneva
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
% P.param1 is the windowsize, must be an integer
function imout =CM_softthresh(P,imin)
winsize=P.param1;

[attacked_im,noise]=wiener2(imin,[winsize winsize]);
mask2=[0.   0.  0.5  0. 0.,
       0.  0.  1  0.  0.,
       0.5    1   1  1    0.5,
       0.  0.  1  0.  0.,
       0.   0.  0.5  0. 0.,];
% Estimate the local mean of f.
%localMean = filter2(ones(nhood), g) / prod(nhood);
localMean = filter2(mask2, imin) /sum(sum(mask2));
% Estimate of the local variance of f.
localVar = filter2(mask2, imin.^2) /sum(sum(mask2)) - localMean.^2;

T=sqrt(2)*noise./sqrt(mean(localVar(:)));
resid=imin - localMean;
imout=localMean+max(0,abs(resid)-T).*sign(resid);
return;