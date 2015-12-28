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
% no parameters required in P
function imout=CM_fmlr(P,imin)

% basic version of the Frequency mode laplacian removal attack proposed by
% Richard Barnett

% check for both cases color and BW
if length(size(imin))==3 % it is a color image
	YIQ=rgb2ntsc(imin);
	imin2=YIQ(:,:,1);
	colorim=1;
else
	colorim=0;
	imin2=imin/255;	
end

imhisteq=histeq(imin2);
% filter with the laplacian
imlap1=filter2([1 1 1;1 -8 1;1 1 1],imhisteq);
%figure;imagesc(imlap1);colormap gray;colorbar;title('after lap removed')

% equalize the histogram of the result
imlapeq=histeq(imlap1);

% add back to the original image
str1=0.05;
imout=imin2+str1*imlapeq;

% inverse color transformation if necessary
if colorim==1
	YIQ(:,:,1)=imout;
	imout=ntsc2rgb(YIQ);
else
	imout=255*imout;
end

