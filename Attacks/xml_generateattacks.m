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
function []=xml_generateattacks(fid,P,compressiontype,compressionval,compressionquality)
imtype='xml';  % not intuitive, but sets the directory implcitly for manipulating the filenames
slow1=1; % All tests timnum=1;
% create a list of all possible attacks from the following types
% each one has an associated function which defines the specifics for the attack
classList=getClassList(P);
for attackClass=classList 
    if strcmp(attackClass,P.JPEGCOMPRESSION_CLASS)
      
      % this is not very clean, but necessary since all attacked images are ultimately stored in JPEG format for simplicity
    if strcmp('J',compressiontype)
      compressionquality=getSubjectiveQuality(P,compressionval,P.JPEGTYPE);
      writeGenericAttack(fid,P,char(attackClass),P.JPEGTYPE,compressionval,compressionquality)
    else
      continue;
    end

  elseif strcmp(attackClass,P.WAVELETCOMPRESSION_CLASS)
    if strcmp('W',compressiontype)
      compressionquality=getSubjectiveQuality(P,compressionval,P.WAVELETTYPE);
      writeGenericAttack(fid,P,char(attackClass),P.WAVELETTYPE,compressionval,compressionquality)
    else
      continue;
    end
  else
    writeGenericAttack(fid,P,char(attackClass),compressiontype,compressionval,compressionquality);
  end

end
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to automatically insert the parameter values
% locations given the locations of the boundaries for comparison,
function string1=writexmlparams(val,paramname,locations,writevalues);
for i=1:length(locations)
  if val<locations(i)
    string1=sprintf('\t<param name="%s">%d</param>\n',paramname,writevalues(i));
    return;
  end
end
string1=sprintf('\t<param name="%s">%d</param>\n',paramname,writevalues(i+1));
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% write a generic xml class

function []=writeGenericAttack(fid,P,attackClass,compressiontype,compressionval,compressionquality)
timnum=1;slow1=1;
[numingroup,tstvec,category]=getAttackParams(P,attackClass,timnum,1,'numims',slow1,compressiontype,compressionval);
P.category=category;
for i=1:numingroup
	if strcmp(compressiontype,'J')
	  fprintf(fid,'<attack id="%s%d_%s%d.jpg" class="%s"> \n',attackClass,i,compressiontype,compressionval,attackClass);
	else
	    fprintf(fid,'<attack id="%s%d_%s%d.jpg" class="%s"> \n',attackClass,i,compressiontype,100*compressionval,attackClass);
	end
	
	fprintf(fid,'\t<param ref="%s">%s</param>\n',P.JPEGORWAV,compressiontype);
	fprintf(fid,'\t<param ref="%s">%1.1f</param>\n',P.COMPRESSIONVAL,compressionval);
	fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SCQ,compressionquality);
	% the function name is always attackClass
	funcname=sprintf('@%s',attackClass) ;	func=eval(funcname);
	feval(func,fid,P,i,tstvec); % add the contents specific to a given attack
	fprintf(fid,'</attack>\n\n');
end
return


%%%%%%%%%%%%%%%%%%%%%%%%% useful functions
 function inserttype(fid,type1)
  fprintf(fid,'\t<type ref="%s"/>\n',type1);
  return;

  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Specific details for each possible class of attacks
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 function rowcol(fid,P,i,tstvec)
 
	inserttype(fid,P.GEOMETRIC_TYPE);
	fprintf(fid,'\t<param ref="rows">%d</param>\n',tstvec(i,1));
	fprintf(fid,'\t<param ref="cols">%d</param>\n',tstvec(i,2));
	fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricSlight);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function nulineremove(fid,P,i,tstvec)
rowcol(fid,P,i,tstvec); % same as row col
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function flip(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricLarge);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cropping(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="percentcropped">%d</param>\n',tstvec(i));
boundaries=[8 25];values=[P.GeometricSlight P.GeometricMedium P.GeometricLarge];
s1=writexmlparams(tstvec(i),P.PARAMS_SGQ,boundaries,values);
fprintf(fid,s1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotation(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="angle">%0.2f</param>\n',tstvec(i));
boundaries=[2.5 25];values=[P.GeometricSlight P.GeometricMedium P.GeometricLarge];
s1=writexmlparams(abs(tstvec(i)),P.PARAMS_SGQ,boundaries,values);
fprintf(fid,s1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotationscale(fid,P,i,tstvec)
rotation(fid,P,i,tstvec);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function scale(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="scale">%0.2f</param>\n',tstvec(i));
boundaries=[0.8 1.2];values=[P.GeometricLarge P.GeometricSlight P.GeometricLarge];
s1=writexmlparams(abs(tstvec(i)),P.PARAMS_SGQ,boundaries,values);
fprintf(fid,s1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function shearing(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="xshear">%0.2f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="yshear">%0.2f</param>\n',tstvec(i,2));
boundaries=[100];values=[P.GeometricMedium];
s1=writexmlparams(1,P.PARAMS_SGQ,boundaries,values);
fprintf(fid,s1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ratio(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="xscale">%0.2f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="yscale">%0.2f</param>\n',tstvec(i,2));
val=getLinearTransformQuality(P,1,tstvec(i,1),tstvec(i,2),1);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,val);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linear(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="T11">%0.3f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="T12">%0.3f</param>\n',tstvec(i,2));
fprintf(fid,'\t<param ref="T21">%0.3f</param>\n',tstvec(i,3));
fprintf(fid,'\t<param ref="T22">%0.3f</param>\n',tstvec(i,4));
val=getLinearTransformQuality(P,tstvec(i,1),tstvec(i,2),tstvec(i,3),tstvec(i,4));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,val);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sharpening(fid,P,i,tstvec)
 
inserttype(fid,P.FILTERING_TYPE);
fprintf(fid,'\t<param ref="window">%d</param>\n',tstvec(i));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricNone);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function reducecolor(fid,P,i,tstvec)
inserttype(fid,P.COLORREDUCE_TYPE);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricNone);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fmlr(fid,P,i,tstvec)
inserttype(fid,P.FILTERING_TYPE);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricNone);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gaussian(fid,P,i,tstvec)
inserttype(fid,P.FILTERING_TYPE);
fprintf(fid,'\t<param ref="window">%d</param>\n',tstvec(i));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricNone);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function medfilt(fid,P,i,tstvec)
hardthresh(fid,P,i,tstvec);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hardthresh(fid,P,i,tstvec)
inserttype(fid,P.DENOISE_TYPE);
fprintf(fid,'\t<param ref="window">%d</param>\n',tstvec(i));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricNone);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function softthresh(fid,P,i,tstvec)
% same as config for hardthresh
hardthresh(fid,P,i,tstvec);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wiener(fid,P,i,tstvec)
% same as config for hardthresh
hardthresh(fid,P,i,tstvec);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dpr(fid,P,i,tstvec)
% same as config for hardthresh
hardthresh(fid,P,i,tstvec);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dprcorr(fid,P,i,tstvec)
hardthresh(fid,P,i,tstvec);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stirmark(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricSlight);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function midpoint(fid,P,i,tstvec)
% similar to hardthresh
hardthresh(fid,P,i,tstvec);
fprintf(fid,'\t<param ref="windowsize">%d</param>\n',tstvec(i));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function trimmedmean(fid,P,i,tstvec)
midpoint(fid,P,i,tstvec);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function templateremove(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricSlight);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function collage(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);

fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_COLLAGETYPE,tstvec(i));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.GeometricLarge);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function waveletcompression(fid,P,i,tstvec)
	inserttype(fid,P.COMPRESSION_TYPE);
% compression is applied by default so no parameters
%fprintf(fid,'\t<param ref="waveletCompressionFactor">%1.1f</param>\n',tstvec(i));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function jpegcompression(fid,P,i,tstvec)
	inserttype(fid,P.COMPRESSION_TYPE);
% compression is applied by default so no parameters
%fprintf(fid,'\t<param ref="jpegCompressionFactor">%1.1f</param>\n',tstvec(i));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function projective(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="angle">%1.2f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="axis">%1.2f</param>\n',tstvec(i,2));
fprintf(fid,'\t<param ref="distfac">%1.2f</param>\n',tstvec(i,3));
fprintf(fid,'\t<param ref="radiusfac">%1.2f</param>\n',tstvec(i,4));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.category(i));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function warp(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="warpfactor">%1.2f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.category(i));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function copy(fid,P,i,tstvec)
inserttype(fid,P.COPY_TYPE);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sampledownup(fid,P,i,tstvec)
inserttype(fid,P.GEOMETRIC_TYPE);
fprintf(fid,'\t<param ref="downsample">%1.2f</param>\n',tstvec(i,1));
fprintf(fid,'\t<param ref="upsample">%1.2f</param>\n',tstvec(i,2));
fprintf(fid,'\t<param ref="%s">%d</param>\n',P.PARAMS_SGQ,P.category(i));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  dither(fid,P,i,tstvec)
inserttype(fid,P.COLORREDUCE_TYPE);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  thresh(fid,P,i,tstvec)
inserttype(fid,P.COLORREDUCE_TYPE);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  dprautoc(fid,P,i,tstvec)
inserttype(fid,P.DENOISE_TYPE);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF Specification of function parameters %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function val=getLinearTransformQuality(P,t11,t12,t21,t22)
% returns a value for the geometric change based
% on the percent change in the transformation
% matrix
tmat=[t11 t12;t21 t22]; 
diffmat=abs(eye(2)-tmat);
totchange=sum(sum(diffmat));
percentChange=100*totchange/2; 
if percentChange==0
  val=P.GeometricNone;
  return;
end;
if percentChange <5
  val=P.GeometricSlight;return;
elseif percentChange<15
  val=P.GeometricMedium;return;
else
  val=P.GeometricLarge;
end
return