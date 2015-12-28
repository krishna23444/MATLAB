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
function attacked_im =CM_dpr(P,imOrig)
% 1st stage denoising (try both wiener and hard thresholding,
% this version uses hard thresh, but wiener is used to estimate
% the watermark for remodulation,
% The remodulation strengths are 3 and 15 for flat and textured
% winsize defaults to 3
% this attack should be improved with better masking

winsize=P.param1;
if exist('winsize')~=1
	winsize=3;
end
minremodval=2;maxremodval=11;
 flipprob=0.3; % between 30% and 50% typically (see articles) 
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


% the thresholding is chosen
% small. We multiply by 0.1 to only remove values between -2 and
% +2.  

% This essentially removes noise from the flat regions
imHardThresh=CM_hardthresh(P,imOrig);
%T=0.125*sqrt(2)*noise./sqrt(mean(localVar(:)));  
%resid=imOrig - localMean;  
%resid_T=ones(size(resid)); resid_T(find(abs(resid)<=T))=0; % mask for the thresholded values
%imHardThresh=localMean+resid_T.*(resid);
% imHardThresh contains the image after WM is removed in flat areas
% that is +/-3 are set to 0 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now do the remodulation part
winsize=3;denoisedIm=attacked_im;
estWM=imOrig-denoisedIm;
%figure;imagesc(imOrig);title('imOrig');colormap gray
%figure;imagesc(estWM);title('estWM');colormap gray


% use a primitive mask for remodulation based on variance
nhood=[3 3];
localMean = filter2(ones(nhood), imOrig) / prod(nhood);
localVar = filter2(ones(nhood), imOrig.^2)/prod(nhood)-localMean.^2;
% Either flip by a value of 3 or 8 depending on variance  
varthresh=30;  varmask=localVar>varthresh;
% depending on the type we either use no prior, correlated prior or
% repetitive prior
%n1=16*(rand(size(imOrig))-0.5);
% basic dpr attack
		  % figure;imagesc(imHardThresh-imOrig);colormap gray;colorbar
  w1 = rand(size(imOrig));
  % the second term adds outliers
  flippositions=(w1<flipprob)+(w1<flipprob/2);
  %  figure;imagesc(flippositions);title('flippositions');colormap gray
  %first add the inverse estimated WM in the selected positions
  tmp=imHardThresh;
  remodnoise=minremodval*flippositions.*sign(estWM).*(1-varmask)+maxremodval*flippositions.*sign(estWM).*(varmask);
  %  tmp=imHardThresh+2*(flippositions.*estWM*(-1));
  % now apply perceptual modulation
  %   figure;imagesc(remodnoise);colormap gray
  attacked_im=imclip(tmp-remodnoise);
  return;
