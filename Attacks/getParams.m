
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
function Params=getParams(select1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parameters to help define the quality of the resulting image

  P.CompressionQualityLow=1;P.CompressionQualityMedium=2;
  P.CompressionQualityHigh=3;P.CompressionQualityVHigh=4;
  P.GeometricNone=0;P.GeometricSlight=1;
  P.GeometricMedium=2;P.GeometricLarge=3;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

  % names of attack TYPES
  
  P.GEOMETRIC_TYPE='geometric';
  P.FILTERING_TYPE='filtering';
  P.COLORREDUCE_TYPE='colorreduce';
  P.COPY_TYPE='protocol';
  P.DENOISE_TYPE='denoise';
  P.COMPRESSION_TYPE='compression';
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%% attack CLASSES (grouped by TYPE)%%%%%%%%%%%%%%5

  %%%%%%%%%%% FILTERING TYPE CLASSES%%%%%%%%%%%%%%%%%%
  P.GAUSSIAN_CLASS='gaussian';
  P.FMLR_CLASS='fmlr';
  P.SHARPENING_CLASS='sharpening';
  
  %%%%%%%%%%%% COLOR REDUCTION TYPE CLASSES %%%%%%%%%
  P.DITHER_CLASS='dither';
  P.THRESH_CLASS='thresh';
  %%%%%%%%%%%%%%%5 PROTOCOL TYPE CLASSES
  P.COPY_CLASS='copy';
  
  % Geometric TYPE CLASSES
  P.COLLAGE_CLASS='collage';            
  P.SHEAR_CLASS='shearing';             
  P.ROTATION_CLASS='rotation';          
  P.ROTATIONSCALE_CLASS='rotationscale';
  P.LINEAR_CLASS='linear';            
  P.SCALE_CLASS='scale';              
  P.RATIO_CLASS='ratio';              
  P.CROP_CLASS='cropping';            
  P.STIRMARK_CLASS='stirmark';        
  P.WARP_CLASS='warp';                
  P.PROJECTIVE_CLASS='projective';    
  P.ROWCOL_CLASS='rowcol';            
  P.NUROWCOL_CLASS='nulineremove';    
  P.SAMPLEDOWNUP_CLASS='sampledownup'; 
  P.TEMPLATE_CLASS='templateremove';   

  %%%%%%%%%%%%% DENOISING TYPE CLASSES %%%%%%%%%%%%%%%%%%%%%%5
  % ML estimators
  P.MEDIAN_CLASS='medfilt';            
  P.TM_CLASS='trimmedmean';            
  P.MIDPOINT_CLASS='midpoint';         
  
  % MAP estimators
  P.HT_CLASS='hardthresh';             
  P.ST_CLASS='softthresh';             
  P.WIENER_CLASS='wiener';             
  % denoising and remodulation
  P.DPR_CLASS='dpr';                   
  P.DPRCORR_CLASS='dprcorr';             
  
  %%%%%%%%%%%%%%% COMPRESSION TYPE  CLASSES%%%%%%%%%%%%%%%%%%%%%%%%
  P.JPEGCOMPRESSION_CLASS='jpegcompression';      
  P.WAVELETCOMPRESSION_CLASS='waveletcompression';
  
  % Each class also uses a flag which states how to handle color images
  % PLANES= the filter is applies to the RGB channels,
  % LUMINANCE=the filter is applied to the luminance plane,  the result is converted to color from
  % the attacked luminance
  % FUNCTION= the associated function accepts a color image and returns a color image
  % for geometric tranformations we tpyically use PLANES,
  
  P.COLORFILTER_PLANES={P.GAUSSIAN_CLASS,P.FMLR_CLASS,P.SHARPENING_CLASS,P.COLLAGE_CLASS,P.SHEAR_CLASS,P.LINEAR_CLASS,P.SCALE_CLASS,P.RATIO_CLASS,P.STIRMARK_CLASS,P.WARP_CLASS,P.ROWCOL_CLASS,P.PROJECTIVE_CLASS,P.ROWCOL_CLASS,P.NUROWCOL_CLASS,P.SAMPLEDOWNUP_CLASS,P.TEMPLATE_CLASS,P.MEDIAN_CLASS,P.TM_CLASS,P.MIDPOINT_CLASS,P.HT_CLASS,P.ST_CLASS,P.WIENER_CLASS,P.DPR_CLASS,P.DPRCORR_CLASS};
 
  
  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%% OTHER PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  P.PARAMS_COLLAGETYPE='collageType';
  P.PARAMS_SGQ='geometricchange'; %subjective Geometric Quality
  P.PARAMS_ROWS='rows';
  P.PARAMS_COLS='cols';
  % %%%%%%%%%%%%%%% globals for compression%%%%%%%%%%%%%
  P.PARAMS_SCQ='subjectiveCompressionQuality';
  P.COMPRESSIONVAL='compressionFactor'; %bpp for wavelet, quality
                                        %for JPEG
  P.JPEGORWAV='jpegorwavelet';
  P.JPEGTYPE='J'; % this is actually a parameter not a type
  P.WAVELETTYPE='W'; % this is actually a parameter not a type
  
  Params=P;
%end
