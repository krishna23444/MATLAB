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
function []=xml_APP_copyright(fid,P)

JPEG='J';WAVELET='W';
 fprintf(fid,'\t<description>'); 
 fprintf(fid,'General Copyright Protection:  includes all attacks\n');
 fprintf(fid,'Weights are chosen as a function of usefuleness of the attack and the image degradation.  \n');
  fprintf(fid,'In general attacked images of poor quality are given a lower weight\n while attacks of more importance are given a higher weight');
 fprintf(fid,'</description>\n\n');
 groupcount=1;groupweight=1;
%%%%%%%%%%%%%%%5
%IMPORTANT: when selecting attacks be sure to choose either attackClass or
% attackType depending on the type or class of attack desired,  check with the file
% attackClass.xml to confirm

 %%%%%%%  Get the global parameters, these are stored in the structure G
 % see the function geparams for the definitions
 G=getparams('GLOBALS');
 %%%%%%%%%%%%%%%%%%%%%%%%%%% FILTERING %%%%%%%%%%%%%%%%%
 groupweight=1;
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Filtering');
 params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
 refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
 for attack={G.GAUSSIAN_CLASS G.SHARPENING_CLASS}
   insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
 end
 endgroup(fid,'attackGroup'); 
  %%%%%%%%%%%%%%%%%%%%%%%%%%% JPEGCOMPRESSION %%%%%%%%%%%%%%%%%
 groupweight=1;
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'JPEG');
 weight=1;  params={G.JPEGORWAV G.PARAMS_SCQ};
 
 refs(1).value=G.JPEGTYPE;  
weights=[1 0.8 0.6 0.4]; 
values=['4' '3' '2' '1'];
for i=1:length(weights)
 refs(2).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,G.COMPRESSION_TYPE,weight,params,refs,'attackType');
end 
 endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% WAVELET %%%%%%%%%%%%%%%%%
 groupweight=1;
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Wavelet');
 weight=1;  params={G.JPEGORWAV G.PARAMS_SCQ};
 
 refs(1).value=G.WAVELETTYPE;  
 weights=[1 0.8 0.6 0.4]; 
values=['4' '3' '2' '1'];
for i=1:length(weights)
 refs(2).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,G.COMPRESSION_TYPE,weight,params,refs,'attackType');
end 

 endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% ROTATION %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Rotation');
params={'angle' G.PARAMS_SCQ G.JPEGORWAV};
refs(1).value=' -1.00 15.00 45.00'; 
attack=G.ROTATION_CLASS;

refs(3).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];
for i=1:length(weights)
 refs(2).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% ROTATION_SCALE %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'RotationScale');
params={'angle' G.PARAMS_SCQ G.JPEGORWAV};
refs(1).value=' -2.00 45.00 10.00'; 
attack=G.ROTATIONSCALE_CLASS;
refs(3).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];
for i=1:length(weights)
 refs(2).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
 endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% LINEAR %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Linear');
params={G.PARAMS_SCQ G.PARAMS_SGQ G.JPEGORWAV};refs(2).min='2';
attack=G.LINEAR_CLASS;

refs(3).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 

endgroup(fid,'attackGroup'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%% SCALE %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Scale');
params={G.PARAMS_SCQ G.JPEGORWAV};
attack=G.SCALE_CLASS;
refs(2).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% Aspect Ratio %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Aspectratio');
params={G.PARAMS_SCQ G.JPEGORWAV 'xscale'};
attack=G.RATIO_CLASS;
refs(2).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];refs(3).value=' 0.80 1.00';
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 

endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% Cropping %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Crop');
params={'percentcropped' G.PARAMS_SCQ G.JPEGORWAV};
attack=G.CROP_CLASS;
refs(3).value=G.WAVELETTYPE;
refs(1).value=['10 20 50 75'];
 weights=[1 0.8 0.5]; 
values=['4' '3' '2'];
for i=1:length(weights)
 refs(2).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%  STIRMARK  %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Bending');
params={G.PARAMS_SCQ G.JPEGORWAV};
attack=G.STIRMARK_CLASS;
refs(2).value=G.WAVELETTYPE;
refs(1).value='4';weight=1;% weight of attakcks in the group
insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% PROJECTIVE %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Projective');
params={G.PARAMS_SCQ G.JPEGORWAV};
attack=G.PROJECTIVE_CLASS;
refs(2).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; values=['4' '3' '2'];
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% WARP %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Warping');
params={G.PARAMS_SCQ G.JPEGORWAV};
attack=G.WARP_CLASS;refs(2).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; values=['4' '3' '2'];
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% SHEAR %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Shearing');
params={G.PARAMS_SCQ G.JPEGORWAV 'xshear'};
attack=G.SHEAR_CLASS;refs(2).value=G.WAVELETTYPE;
 weights=[1 0.8 0.5]; values=['4' '3' '2'];
 refs(3).value='5.00';
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% ROWCOL %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Row_col');
params={G.PARAMS_SCQ G.JPEGORWAV}; weights=[1 0.8 0.5]; values=['4' '3' '2'];
refs(2).value=G.WAVELETTYPE;
for attack={G.ROWCOL_CLASS G.NUROWCOL_CLASS}
for i=1:length(weights)
 refs(1).value=values(i);weight=weights(i); 
 insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 

end
endgroup(fid,'attackGroup'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%% MAP %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'MAP');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.HT_CLASS G.ST_CLASS G.WIENER_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% ML %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'ML');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.MEDIAN_CLASS G.TM_CLASS G.MIDPOINT_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% DPR %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Remodulation');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.DPR_CLASS G.DPRCORR_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% COPY %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Copy');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.COPY_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% COLLAGE %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Collage');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.COLLAGE_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% TEMPLATE REMOVAL %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'TemplateRemove');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.TEMPLATE_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% UP_DOWN SAMPLING %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'SampleDownUp');
params={G.JPEGORWAV G.COMPRESSIONVAL 'downsample'};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; 
refs(2).value='100.0'; refs(3).value=' 0.75 0.50';
attack=G.SAMPLEDOWNUP_CLASS;
for attack={G.SAMPLEDOWNUP_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end 
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% DITHER %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'colorReduce');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.DITHER_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% THRESH %%%%%%%%%%%%%%%%%
groupweight=1;
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'colorReduce');
params={G.JPEGORWAV G.COMPRESSIONVAL};weight=1;% weight of attakcks in the group
refs(1).value=G.JPEGTYPE; refs(2).value='100.0';
for attack={G.THRESH_CLASS}
  insert_attackGroup2(fid,attack,weight,params,refs,'attackClass');
end
endgroup(fid,'attackGroup'); 
