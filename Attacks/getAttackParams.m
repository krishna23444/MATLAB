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
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001.
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
function [imppm,vals,category]=getAttackParams(P,imtype,timnum,tstval,type2,slow1,compressiontype,compressionval)% call the first time with type2 set to 'numims' so that the number of tests in% a given category will be returned in the parameter imppm% the available imtypes are% imtype={'flip' 'gaussian' 'medfilt' 'sharpening' 'rowcol' 'cropping'% 'rotation' 'rotationscale' 'scale' 'shearing' 'linear' 'ratio' % 'reducecolor' 'fmlr' 'stirmark' 'jpeg' % 'ML_midpoint' 'ML_trimmedmean' 'nulineremove',% 'hardthreshbend', 'wiener' 'softthresh' 'hardthresh'%   'dpr', 'dprcorr' 'templateremove'% 'waveletcompression', 'copy'% 'collage1' 'collage2' 'collage3' 'collage4'}% 'sampledownup'% note that the parameter imppm is no longer used to store an image name, this will be removed in future versions

category=[]; % used to store auxiliary info, such as the amount of distortionif exist('slow1')==0  slow1=1;endif strcmp(type2,'ppm')  dir1=sprintf('D:\\Frédéric\\StirmarkTests\\t%dm\\ppm\\',timnum);elseif strcmp(type2,'xml')    dir1=sprintf('');else  dir1=sprintf('D:\\Frédéric\\StirmarkTests\\t%dm\\',timnum);end
%default to 1 implies only one image in set not used when there are no parameters in determining image.vals=[1]; 
switch char(imtype)case 'rowcol',    if slow1==1        vals=[1 1;1 5;17 5;5 1;5 17];    else         vals=[1 1;1 5;17 5];    end    imppm=sprintf('%s_%d_row_%d_col_removed.jpg',dir1,vals(tstval,1),vals(tstval,2));case 'medfilt',    if slow1==1        vals=[2 3 4]';    else        vals=[2 4]';    end    imppm=sprintf('%s%_dx%d_median_filter.jpg',dir1,vals(tstval),vals(tstval));case 'cropping',    if slow1==1        vals=[1 2 5 10 15 20 25 50 75]';    else        vals=[50 75]';    end    imppm=sprintf('%s_cropping_%d.jpg',dir1,vals(tstval));case 'flip',    imppm=sprintf('%s_flip.jpg',dir1);case 'reducecolor',    imppm=sprintf('%s_reduce_colour.jpg',dir1);case 'sharpening',	vals=[3]';    imppm=sprintf('%s_Sharpening_3_3.jpg',dir1);case 'stirmark',    imppm=sprintf('%s_stirmark_random_bend.jpg',dir1);case 'fmlr',    imppm=sprintf('%s_FMLR.jpg',dir1);case 'gaussian',	   vals=[3 5]';    imppm=sprintf('%s_Gaussian_filtering_3_3.jpg',dir1);case 'scale',    if slow1==1        vals=[0.5 0.75 0.9 1.1 1.5 2]';    else        vals=[0.5 0.75 1.5 2]';    end    imppm=sprintf('%s_scale_%1.2f.jpg',dir1,vals(tstval));case 'linear',    vals=[1.007 0.010 0.010 1.012;    1.010 0.013  0.009 1.011 ;    1.013 0.008 0.011 1.008;	1.01 0.02 -0.02 1.02;	1.15 -0.02 -0.03 0.9;	0.8 -0.1 0.05 1.1;	-0.85 -0.2 -0.05 1.3;    ];
    imppm=sprintf('%s_linear_%1.3f_%1.3f_%1.3f_%1.3f.jpg',dir1,vals(tstval,1),vals(tstval,2),...                  vals(tstval,3),vals(tstval,4));case 'ratio',    if slow1==1        vals=[0.8 1;0.9 1;1 0.8; 1 0.9;1 1.1 ; 1 1.2; 1.1 1;1.2 1 ];    else        vals=[1 0.8;1.2 1 ];
    end    imppm=sprintf('%s_ratio_x_%1.2f_y_%1.2f.jpg',dir1,vals(tstval,1),vals(tstval,2));case 'shearing',
    vals=[0 1;1 0;0 5;5 0;1 1;5 5];    imppm=sprintf('%s_shearing_x_%1.2f_y_%1.2f.jpg',dir1,vals(tstval,1),vals(tstval,2));case 'rotation',    if slow1==1        vals=[0.25 -0.25 0.5 -0.5 0.75 -0.75 1 -1 10 15 2 -2 30 45 5 90]';    else        vals=[-2 30 45]';    end    imppm=sprintf('%s_rotation_%1.2f.jpg',dir1,vals(tstval));case 'rotationscale'    if slow1==1        vals=[0.25 -0.25 0.5 -0.5 0.75 -0.75 1 -1 10 15 2 -2 30 45 5 90]';    else        vals=[-2 30 45]';    end    imppm=sprintf('%s_rotation_scale_%1.2f.jpg',dir1,vals(tstval));case 'hardthresh',	   vals=[3 5]';    imppm=sprintf('%sMAPHard_thresh.jpg',dir1);	case 'softthresh',	   vals=[3 5]';    imppm=sprintf('%sMAPSoft_thresh.jpg',dir1);	case 'dpr',	   vals=[3 5]';    imppm=sprintf('%sMAPDPR.jpg',dir1);	case 'dprcorr',	   vals=[3 5]';    imppm=sprintf('%sMAPDPR_corr.jpg',dir1);	case 'templateremove',    imppm=sprintf('%sMAPTemplate_Removal.jpg',dir1);case 'wiener',	   vals=[3 5]';    imppm=sprintf('%sMAPWiener.jpg',dir1);case 'nulineremove',   vals=[12 9;9 12];   imppm=sprintf('%sMAPNU_Line_RemovalR%d_C%d.jpg',dir1,vals(tstval,1),vals(tstval,2)); case 'midpoint',   vals=[3 5]';   imppm=sprintf('%sML_MidPoint%dx%d.jpg',dir1,vals(tstval),vals(tstval));  case 'trimmedmean',   vals=[3 5]';   imppm=sprintf('%sML_TM%dx%d.jpg',dir1,vals(tstval),vals(tstval));case P.JPEGCOMPRESSION_CLASS, % for jpegcompression the factors are givne in xml_writeattacks	%   if slow1==1	%       vals=[10 15 20 25 30 35 40 50 60 70 80 90]';	%   else	%        vals=[10 15 20 25 30 35 40]';	%    end	imppm=sprintf('%s_JPEG_%d.jpg',dir1,vals(tstval));case P.WAVELETCOMPRESSION_CLASS, %  vals=[1 2 3 4 5 6 7 0.1 0.2 0.3 0.4 0.5 0.7 0.9]';   imppm=sprintf('%swcbbp%1.1f.jpg',dir1,vals(tstval));   case 'copy',   vals=[1]';   imppm=sprintf('%scopy%d.jpg',dir1,vals(tstval));   case 'collage',   imppm=sprintf('%scollage.jpg',dir1);     vals=[1 2]';case 'projective'	% parameters are angle, axis, distancefac, radiusfac	% axis=1 for x-axis rotation, 3 for cylinder y axis, 4 for sphere	% see projective function for more details	vals=[2.5 1 2 2;		  5 1 2 2;		  10 1 2 2;		  30 1 2 2;		  1 3 2 1.3;		  1 3 2 1.5;		  1 3 2 2;		  1 4 2 1.3;		  1 4 2 1.5;		  1 4 2 2];	  % geometric change of each attack	  % corresponds to parameters in vals array above	  % these are set empirically to categorize the list of attacks 	  %	 GeometricNone=0;GeometricSlight=1;GeometricMedium=2;GeometricLarge=3;	  category=[1 2 2 3 3 2 1 3 2 1];	  	imppm=sprintf('projective');case 'warp'	vals=   [3  6  9  12 ]'; % warp factors becomes visible at 2-3	category=[2   2   3   3 ]; % the amount of subjective geometric changecase P.SAMPLEDOWNUP_CLASS %vals=downsaple and upsample factors
    vals=[0.75 1.333;
          .5   2;  %the final image size is the same as the original
          0.75 1.3;
          0.5 1.9;];
    category=[0 0 1 1];  
case P.DITHER_CLASS
    % no params for this attack
case P.THRESH_CLASS
    % no params
case P.DPRAUTOC_CLASS
    % no params
otherwise 
      sprintf('NO MATCHING ATTACK CLASS FOR %s',char(imtype))
      imppm=[];end 
if strcmp(type2,'numims')    imppm=size(vals,1);else % add the compressiontype to the end		if strcmp('J',compressiontype)		tmp=sprintf('_%s_%d',compressiontype,compressionval);	else		tmp=sprintf('_%s_%d',compressiontype,10*compressionval);	end	imppm=strcat(imppm,tmp);end
