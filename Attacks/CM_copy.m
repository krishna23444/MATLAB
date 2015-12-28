%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Sviatoslav Voloshynovskiy,   Maribel Madueno, Shelby Pereira   %
%                         Computer Vision Group                        %
%                               05/02/01                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copyright (c) 2001, University of Geneva
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
% no parameters for this attack,  uses the collage image as the targer image
% the WM is estimated from WI and copied to tmpcollagebw

function [NewWI,Size]=CM_copy(P,WI)

WI=getlum255(WI);
[m,n]=size(WI);

% load the target image and resize to original image size
I=double(imread('tmpcollagebw.jpg'));
I=imresize(I,[m n]);
strhigh=10; %strength in textured regions;
strlow=3; %strength in flat regions;
EstWM=zeros(size(WI));
for k=1:size(WI,3)
    
    % Estimate of the watermark sign
    [EstWM(:,:,k),NoiseStd]=GetWatermark(WI(:,:,k));
    %=A;
    
    % Calculation of the perceptual mask from the new target image.
    NVF1=nvf(I(:,:,k),'nsG');

    % Normalization of NVF to be in the range of (0:1).
    NVF1=NVF1/max(NVF1(:));    

    % !!!!!!!!!!!!!!!!!!!!!!!!
    Factor(:,:,k)=((1-NVF1)*strhigh+NVF1*strlow);

end
%figure;imagesc(Factor);title('NVF');colorbar;colormap gray
% Addition of the watermark to the target image.

NewWI=I+Factor.*EstWM;
Size='1';
    
% Clipping.
NewWI=Clipping(NewWI);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555555

function [A]=Clipping(A)

A=max(min(A,255*ones(size(A))),zeros(size(A)));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [EstWM,NoiseStd]=GetWatermark(WI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimation of noise variance from pre-filtered image. Computation of
% NVF to exclude the edges and textures from variance estimation.
f=wiener2(WI);
[NVF,LocalMeanf]=nvf(f,'nsG',100);
R=(WI-LocalMeanf).*NVF;
NoiseStd=median(abs(R(:)))/0.6745; % see publication for derivation
                                   % of result
NoiseVar=NoiseStd^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Watermark estimation based on the Wiener filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nhood=[5 5];
mask1=[ 0.  0.  1   0.  0.
        0.  0.  1   0.  0.
        1   1   1   1   1
        0.  0.  1   0.  0.
        0.  0.  1   0.  0.];

% Estimate the local mean of g.
LocalMean=filter2(mask1,WI)/sum(mask1(:));

% Estimate of the local variance of f.
LocalVar=filter2(mask1,WI.^2)/sum(mask1(:))-LocalMean.^2;

Value=max(max(LocalVar-NoiseVar,0)-NoiseVar,0)./max(max(LocalVar-NoiseVar,0),NoiseVar);

% Estimate of the cover image.
EstI=Value.*(WI-LocalMean)+LocalMean;

% Estimate of the watermark.
EstWM=sign(WI-EstI);
