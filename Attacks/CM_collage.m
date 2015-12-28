%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Maribel Madueno                            %
%                         Computer Vision Group                        %
%                       Last modification 09/02/01                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set type to 1 for basic collage
% 2 for collage with rotation and scale

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
function [C]=CM_collage(P,I)
Type=P.param1;

if iscolor(I)
  CollageFname='collagergb.jpg';
else
  CollageFname='tmpcollagebw.jpg';
end

Collage=double(imread(CollageFname));
CollageSize=[size(Collage,1) size(Collage,2)];

if Type==1
  C=Collage;
  [y1,y2]=RandomPos(size(C,1),size(I,1));
  [x1,x2]=RandomPos(size(C,2),size(I,2));
  C(y1:y2,x1:x2,:)=I;
end

if Type==2
  ang1=20;
  P.param1=ang1;
  I2=CM_rotationscale(P,I);
  C=Collage;
  [y1,y2]=RandomPos(size(C,1),size(I2,1));
  [x1,x2]=RandomPos(size(C,2),size(I2,2));
  C(y1:y2,x1:x2,:)=I2;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

function [x1,x2]=RandomPos(THbloque,x)

if THbloque<x
    errordgl('Fatal error','Generating random position')
end

% generation of initial position
x1=NRandom(THbloque);   
x2=x1+x-1;
while x2>THbloque
  x1=NRandom(THbloque);   
  x2=x1+x-1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [y1]=NRandom(Size)
y1=max(round(Size*rand(1)),1);


