% Copyright (c) 2001, Mariebl Madueno, University of Geneva
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
function []=writeQualityMetrics(fid,imOrig,imWM)

% Watson metric

[m1,n1,o1]=size(imOrig);
[m2,n2,o2]=size(imWM);

if (m1~=m2)|(n1~=n2)|(o1~=o2)
  disp(['images of different sizes!!!! setting metrics to -1'])
  TPE=-1;NLPE1=-1;NLPE2=-1;psnr=-1;wpsnr=-1;
else
  [TPE,NLPE1,NLPE2,MAXLPE]=WatsonMetric(imOrig,imWM,16);        
  [psnr,wpsnr]=psnrMetric(imOrig,imWM,4);
end
WriteWatson(fid,TPE,NLPE2,NLPE1);
% PSNR metric and weigthened PSNR.
WritePSNR(fid,psnr);          
WritePSNR(fid,wpsnr);
   