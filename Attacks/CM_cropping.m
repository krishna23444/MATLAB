% function imout=CM_cropping(P,imin,siz,type1)
% crops out a square portion of size siz, from the center of imin
% if type1==0 a block of size is cropped from the center
% type1=1, a band of width size of crop from the edge
% type1=2, siz is the percent of pixels to crop from the center
% P.param1 is the amount to crop
% if P.param2 is -99999 then we crop a percent (by default)

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
% parameters
% P.param2 should be set to -9999
% P.param1 is the percent area to crop from the edge between 0-100


function imout=CM_cropping(P,imin)
if P.param2<-1000
  type1=2; % crop a percent by default
else
  type1=P.param2; % otherwise we can crop a block=0 or a band=1
end
siz=P.param1;

if length(size(imin))==3
  [a,b,dum]=size(imin);
else
  [a,b]=size(imin);
end
if exist('type1')==0
  type1=0;
end

if type1==0
  centx=floor(b/2);
  centy=floor(a/2);
  if length(siz)==1
    sizr=siz;sizc=siz;
  else
    sizr=siz(1);    sizc=siz(2);
  end
  xmin=centx-floor(sizc/2);
  ymin=centy-floor(sizr/2);
  imout=imcrop(imin,[xmin ymin sizc-1 sizr-1]);
elseif type1==1
  % size represents the size of the band around the edges to crop
  imout=imin(1+siz:a-siz,1+siz:b-siz);
  return

  % ************************************ %
% the most important case used in checkmark is a percent area cropped as below

elseif type1==2
  %note that the imcrop function works in xy coordinates
  numrows=floor(a*sqrt((100-siz)*0.01));
  numcols=floor(b*sqrt((100-siz)*0.01));
  midr=floor(numrows/2)+1;  midc=floor(numcols/2)+1;
  starta=midr-floor(numrows/2);  startb=midc-floor(numcols/2);
  imout=imcrop(imin,[startb starta numcols numrows]);  
end
