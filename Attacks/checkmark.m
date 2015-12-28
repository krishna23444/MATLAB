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
% Sviatoslav Voloshynovskiy, Shelby Pereira, Victor Iquise and Thierry Pun, 
% Attack modelling: Towards a second generation benchmark, Signal
% Processing
% Special Issue: Information Theoretic Issues in Digital
% Watermarking, May, 2001. V. Cappellini,
%  M. Barni, F. Bartolini, Eds.  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%

function []=checkmark(imin,configFname,baseAttackedImname);
ver1=checkmarkversion(0);
COLORFILTER_FUNCTION=1;
COLORFILTER_PLANES=2;
sprintf('Checkmark version %s  Shelby Pereira, Copyright 2001 (c) University of Geneva\n\n',ver1)

% only supports black and white images
P=getParams('globals');
configFname
% read in config file with  all parameters
% p(1) to p(8) are the parameters

[funcName,fileName,p1,p2,p3,p4,p5,p6,p7,p8]=textread(configFname,'%s%s%s%s%s%s%s%s%s%s');
numattacks=size(p1,1);

% the first three parameters deal with the compression
% p4-p8 are potentially real parameters
% unused params are set to -99999

previousname='';currentname=''; %used so that we do not perform a basic attack 2 times
% this is useful since we can perform an attack followed by all the required compressions
% without repeating the basic attack, a considerable processing time is saved
% note that this assumes that the config file is ordered correctly.

for i=1:numattacks % for each attack call the corresponding function to generate the basic attacked image
  P.param1=str2double(p3(i));  P.param2=str2double(p4(i));   P.param3=str2double(p5(i));  
  P.param4=str2double(p6(i));  P.param5=str2double(p7(i));  
  
  % generate the current base attack name
  loc1=findstr(char(fileName(i)),'_');
  % '_' is the delimiter that separates the basic
  % attack from the compression value
  attackName=char(fileName(i));  currentname=attackName;
  currentname=currentname(1:loc1-1);
  func1=sprintf('CM_%s',char(funcName(i)));

  if strcmp(currentname,previousname)==0
    %if the same dont repeat the attack
    % if not the same we must compute the new attacked image
    previousname=currentname;
    if iscolor(imin)
      imresult=zeros(size(imin));
      % first see which type of filtering to use
      % if it is in the list to be plane filtered we filter the image
      % plane by plane.  By default,  color images are taken care of in the 
      % attacking function 
      ind=strmatch(char(funcName(i)),P.COLORFILTER_PLANES,'exact');
      if isempty(ind)
	COLORPROCESS=COLORFILTER_FUNCTION;
      else
	COLORPROCESS=COLORFILTER_PLANES;
      end
      
      switch COLORPROCESS
       case COLORFILTER_PLANES % filter plane by plane
%	disp(['filtering plane by plane'])
	imresult=[];
	for i=1:3
	  implane=imin(:,:,i);
	  imresult(:,:,i)=uint8(feval(func1,P,implane));
	end
       case COLORFILTER_FUNCTION  % call the function with the color image
%	disp(['filtering color image in function'])
	imresult=feval(func1,P,imin);
      end
    else
      imresult=feval(func1,P,imin);
    end
  end
  compressWrite(imresult,strcat(baseAttackedImname,attackName),p1(i),p2(i));
end

% %%%%%%%%%%%%%%%%%
function res=normim0_255(imin)
res=imin;
res(find(res<0))=0;
res(find(res>255)) = 255;
		
% %%%%%%%%%%%%%%%%%
function  []=compressWrite(im,fname,compressiontype,compressionfactor)
im2=uint8(normim0_255(im));
fname
if strcmp(compressiontype,'J') % apply JPEG compression
%  imwrite(im2,'Quality',compressionfactor,fname);
  imwrite(im2,fname,'Quality',str2double(compressionfactor));
elseif strcmp(compressiontype,'W') 
  % apply WAVELET compression
  % factor must be divided by 100 to correspond to bits per pixel
  tmpfname='tmpJasper.pgm';
  tmpfnameppm='tmpJasper.ppm';
  
  ftemp=char(fname);
  if size(im2,3)==3
    im2=double(im2)/255;
    ppmwrite(im2(:,:,1),im2(:,:,2),im2(:,:,3),tmpfnameppm);
    jasperCompress(tmpfnameppm,ftemp,str2double(compressionfactor));
  else
    pgmwrite(double(im2)/255,tmpfname,'raw');
    jasperCompress(tmpfname,ftemp,str2double(compressionfactor));
  end
end
return

