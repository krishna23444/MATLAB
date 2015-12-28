% Copyright (c) 2001, Shelby Pereira, Sviatoslav Voloshynovskiy, University of Geneva
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
function attacked_im =CM_dprcorr(P,imOrig)
% 1st stage denoising (try both wiener and hard thresholding,
% this version uses hard thresh, but wiener is used to estimate
% the watermark for remodulation,
% The remodulation strengths
% winsize defaults to 3
winsize=P.param1;
if exist('winsize')~=1
	winsize=3;
end
minremodval=4;maxremodval=16;
rand('state',2);
[attacked_im,noise]=wiener2(imOrig,[winsize winsize]);
mask2=[0.   0.  0.5  0. 0.,
       0.  0.  1  0.  0.,
       0.5    1   1  1    0.5,
       0.  0.  1  0.  0.,
       0.   0.  0.5  0. 0.,];
% Estimate the local mean and variance of f.
localMean = filter2(mask2, imOrig) /sum(sum(mask2));
localVar = filter2(mask2, imOrig.^2) /sum(sum(mask2)) - localMean.^2;

% imHardThresh contains the image after WM is removed in flat areas
imHardThresh=CM_hardthresh(P,imOrig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now do the remodulation part
winsize=3;denoisedIm=attacked_im;
estWM=imOrig-denoisedIm;

% use a primitive mask for remodulation based on variance
nhood=[3 3];
localMean = filter2(ones(nhood), imOrig) / prod(nhood);
localVar = filter2(ones(nhood), imOrig.^2)/prod(nhood)-localMean.^2;
% Either flip by a value of 3 or 8 depending on variance  
varthresh=30;  varmask=localVar>varthresh;

%n1=16*(rand(size(imOrig))-0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ATTack with correlated prior on WM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n]=size(imOrig);m2=floor(m/2);n2=floor(n/2);  %up sample afterward  
w1=rand(m2,n2);
flipprob=0.4; % probability of flipping  between 40-60 percent
  flippositions2=(w1<flipprob);
  flippositions=zeros(m,n);
  [I,J]=find(flippositions2); estsignWM=zeros(size(estWM));
  for i=1:length(I) % only modify 2-3 of the positions
	  flippositions(2*I(i)-1,2*J(i)-1)=1;
	  flippositions(2*I(i),2*J(i))=2;
	  flippositions(2*I(i)-1,2*J(i))=0;
	  flippositions(2*I(i),2*J(i)-1)=0;
  end
%  figure;imagesc(flippositions);title('flippositions');colormap gray
  tmp=imHardThresh;
   remodnoise=minremodval*flippositions.*sign(estWM).*(1-varmask)+ maxremodval*flippositions.*sign(estWM).*(varmask);
%      figure;imagesc(remodnoise);colormap gray
   % now apply perceptual modulation
  attacked_im=imclip(tmp-remodnoise);
