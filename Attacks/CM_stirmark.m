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
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
% this attack should be run with no parameters,  typically use default

function imout=CM_stirmark(P,imOrig,Zcord1,numWaves,pixelshift)

% generates images which are warped
% the key part is a call to the projective transformation routine
if exist('pixelshift')~=1
	pixelshift=1.2;  % apply a random pixel shift
end
if exist('seed1')~=1
	seed1=1; %seed the random number generator, it should be set to the same value
	% when applying the attack to 3 planes (RGB)
end
if exist('numWaves')~=1
	numWaves=4; % the strength of the jittering distortion
end

% generate sine waves with random phases on the Z coordinate and
% then use a projective transformation to generate a warping effect
% a random pixel shift is also applied

rand('state',10);

%[m,n]=size(imOrig);numz=1;imOrig2=[zeros(m,numz),imOrig,zeros(m,numz)];  
%[m,n]= size(imOrig2);imOrig2=[zeros(numz,n);imOrig2;zeros(numz,n)];
imOrig2=imOrig;
[m,n]=size(imOrig2);
tmp1=slowvariation(m,n,numWaves);
Zcord=pixelshift*(rand(m,n)-0.5)+tmp1;


% figure;imagesc(Zcord);drawnow
P.param5=Zcord;
P.param6=Zcord;
PROJECTIVEWARP=7;
ang1=0;distfac=1.01;dum1=0;
P.param1=ang1;
P.param2=PROJECTIVEWARP;
P.param3=distfac;
P.param4=dum1;

if exist('Zcord1')~=1
  imout=CM_projective(P,imOrig2);
else
  imout=CM_projective(P,imOrig2,Zcord1);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function matout=slowvariation(m,n,numSineWaves)

avgperiod=100;variation=100;
periods=variation*(rand(numSineWaves,2)-0.5)+avgperiod;

min1=-floor(m/2);max1=min1+m-1;vecy=min1:max1;
min1=-floor(n/2);max1=min1+n-1;vecx=min1:max1;

b=[];c=[];  b=zeros(size(vecy));  c=zeros(size(vecx));
rndphase=2*pi*(rand(size(periods))-0.5);
matout=zeros(m,n);b=zeros(m,n);
alph1=2*pi*(rand(size(periods))-0.5);
for i=1:m
  for j=1:n
    for k=1:size(periods,1)
      b(i,j)=sin((2*pi/periods(k,1))*vecx(j)*cos(alph1(k,1))+(2*pi/periods(k,2))*vecy(i)*sin(alph1(k,2))+rndphase(k,1))+b(i,j);
 %     c=cos((2*pi/periods(k,2))*vecy(i)+rndphase(k,2))+c;
    end
  end
end
matout=b;  
% add a random displacement to all pixels
