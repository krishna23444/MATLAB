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
function imout =CM_nulineremove(P,imin)
%function imout=nonuniform_line_removal(imin,numlinesx,numlinesy,rand1)
% P.param1 and 2 are the number of lines to remove in the x and y directions
% set P.param3 to 1 to add a random displacement to the # of lines removed
% set P.param3 to 0 to remove lines at uniform intervals
numlinesx=P.param1;
numlinesy=P.param2;
rand1=P.param3;

if rand1<-9999
  rand1=1; %if the parameter doesn't exist we apply nonuniform removal
end


[m,n]=size(imin);
val=min([m n]);
val=val-20;


avgstepx=floor(val/numlinesx);
avgstepy=floor(val/numlinesy);
rand('state',1);
rowremove=zeros(1,numlinesy);colremove=zeros(1,numlinesx);

for i=1:numlinesy
  rowremove(i)=i*avgstepy-rand1*round(avgstepy*rand(1)/2);
end

for i=1:numlinesx
  colremove(i)=i*avgstepx-rand1*round(avgstepx*rand(1)/2);
end

imout=imin;

for i=1:length(rowremove)
  imout=[imout(1:rowremove(i)-1,:);imout(rowremove(i)+1:end,:)];
end
for i=1:length(colremove)
  imout=[imout(:,1:colremove(i)-1),imout(:,colremove(i)+1:end)];
end
