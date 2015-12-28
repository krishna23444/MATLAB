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
% P.param1=warpfactor,  increase to increase the distortions

function imout=CM_warp(P,imOrig)

% generates images which are warped
% the key part is a call to the projective transformation routine
% P.param1 is the warp factor, increase to increase distortions
if exist('pixelshift')~=1
	pixelshift=1;  % apply a random pixel shift
end
if exist('seed1')~=1
	seed1=1; %seed the random number generator, it should be set to the same value
	% when applying the attack to 3 planes (RGB)
end

% generate sine waves with random phases on the Z coordinate and
% then use a projective transformation to generate a warping effect
% a random pixel shift is also applied

rand('state',10);
[m,n]=size(imOrig);numz=1;
%imOrig2=[zeros(m,numz),imOrig,zeros(m,numz)];  [m,n]= size(imOrig2);
%imOrig2=[zeros(numz,n);imOrig2;zeros(numz,n)];[m,n]=size(imOrig2);
imOrig2=imOrig;
periods=[300 550 185 1200;170 250 470 1400]';
min1=-floor(m/2);max1=min1+m-1;vecy=min1:max1;
min1=-floor(n/2);max1=min1+n-1;vecx=min1:max1;
b=[];c=[];
b=zeros(size(vecx));  c=zeros(size(vecy));
rndphase=2*pi*rand(size(periods));
for i=1:length(periods)
	b=sin((2*pi/periods(i,1))*vecx+rndphase(i,1))+b;
	c=sin((2*pi/periods(i,2))*vecy+rndphase(i,2))+c;
end
warpfactor=P.param1;
maxsz=max([m n]);  Zcord=maxsz+warpfactor.*c'*b;
% add a random displacement to all pixels

Zcord=(Zcord+pixelshift*(rand(m,n)-0.5));
PROJECTIVEWARP=6;
ang1=60;distfac=1.01;dum1=0;
NUMWAVES=floor(warpfactor+4);
P.param1=ang1;
P.param2=PROJECTIVEWARP;
P.param3=distfac;
P.param4=dum1;pixelShift=0.5;
imout=CM_stirmark(P,imOrig2,Zcord,NUMWAVES,pixelShift);
