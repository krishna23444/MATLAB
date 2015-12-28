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
% parameters: P.param1=xshear as a percent (0-100)
%             P.param2=yshear as a percent

function imout=CM_shearing(P,imin)

% note that parameters are given as a percent
tmat=[1 P.param1/100;P.param2/100 1];

minx=1;miny=1;
% x runs in columns, y in rows
[maxy,maxx]=size(imin);


% calculate the dimensions of the new image
vals=tmat*[minx miny;minx maxy;maxx miny;maxx maxy]';


tmaxx=max(vals(1,:));
tmaxy=max(vals(2,:));

tminx=min(vals(1,:));
tminy=min(vals(2,:));

tminx=floor(tminx);
tminy=floor(tminy);
tmaxx=floor(tmaxx);
tmaxy=ceil(tmaxy);



vecx=tminx:tmaxx;vecy=tminy:tmaxy;

tmatinv=inv(tmat);

[tx,ty]=meshgrid(vecx,vecy);
newcords=tmatinv*([tx(:),ty(:)]');

[x,y]=meshgrid(1:maxx,1:maxy);
lx=length(vecx);ly=length(vecy);

newx=reshape(newcords(1,:),ly,lx);
newy=reshape(newcords(2,:),ly,lx);
%sprintf('interpolating to get transformed image')

vecout=interp2(x,y,double(imin),newx,newy,'bicubic');

imout=killnan(vecout);
