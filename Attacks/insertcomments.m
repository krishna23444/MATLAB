function insertcomments(fid,commenttype)

switch commenttype
 case 'techapp'
  TEXT(fid,'Application/Technology table.  Results of technologies as a function of application');
  TEXT(fid,'Numbers quoted are the percentage of correct detections');
 case 'Collage'
    TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'Collage1: the watermarked image is pasted onto a new image');
  TEXT(fid,'Collage2: the watermarked image is pasted onto a new image and then rotated and scaled');
 case 'Bending'
    TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'Bending: Approximates the Random Bending Attack');
 case 'Copy'
    TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'The watermark is copied from one image to another ');
  TEXT(fid,'NOTE:  A detected watermark in the trarget image is a failure i.e. score=0');
 case 'Linear'
  TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'T11, T12, T21, T22 are the linear transformation parameters ');
 case 'Projective'
  TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'projective1, projective2, projective3,projective4,: rotations along x axis in 3D followed by perspective projection');
  TEXT(fid,'projective5, projective6, projective7: model video distortions on x and y axis');
  TEXT(fid,'projective8, projective9, projective10: model video distortions only on 1 axis');
  TEXT(fid,'<B>PARAMETERS</B>');
  TEXT(fid,'angle=rotation agle');
  TEXT(fid,'axis=1 for X,2 for Y axis, 3 and 4 for video distortions ');
  TEXT(fid,'distfac=distance to projective plane');
  TEXT(fid,'radiusfac:  controls the amount of video distortions');
 case 'Remodulation'
  TEXT(fid,'<BR><B>REMARKS</B>');
  TEXT(fid,'Denoising and Remodulation attack');
  TEXT(fid,'DPR is the basic remodulation attack');
  TEXT(fid,'DPRcorr is the basic remodulation attack assuming a correlated watermark');
  TEXT(fid,'window is the window size used in the prediction');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

function TEXT(fid,str1)
%opentag(fid,'p'); 
fprintf(fid,'%s<BR>',str1);
%closetag(fid,'p');