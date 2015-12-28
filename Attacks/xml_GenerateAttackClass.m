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
function []=xml_GenerateAttackClass(fid,P)
imtype='xml';  % This justs sets the directory to nothing useful for manipulating the filenames
slow1=1;
% All tests timnum=1;
% create a list of all possible attacks from the following types
% each one has an associated function which defines the specifics for the attack
classList=getClassList(P);

for attackClass=classList 
		attackClass
writeGenericClass(fid,char(attackClass),P);
end
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% write a generic xml class
function []=writeGenericClass(fid,attackClass,P)
timnum=1;slow1=1;
fprintf(fid,'<attackClass id="%s"> \n',attackClass);
fprintf(fid,'<name>%s</name> \n',attackClass);
i=0;tstvec=0;
funcname=sprintf('@%s',attackClass);func=eval(funcname);

fprintf(fid,'\t<type ref="%s"/>\n','all');
fprintf(fid,'\t<param id="%s" attrib="extracompression"/>\n',P.JPEGORWAV);
fprintf(fid,'\t<param id="%s" attrib="extracompression"/>\n',P.COMPRESSIONVAL);

feval(func,fid,P,i,tstvec); % add the contents specific to a given attack

%fprintf(fid,'\t<param id="%s" attrib="hidden"/>\n',P.PARAMS_SCQ);

fprintf(fid,'</attackClass>\n\n');
return
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Specific details for each possible class of attacks
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 function insertdata(fid,type1,params)
 fprintf(fid,'\t<type ref="%s"/>\n',type1);
if exist('params')==1
  for string1=params
    fprintf(fid,'\t<param id="%s"/>\n',char(string1));
  end
end
return;


%%%%%%%%%%%%%%%%%%%%%%
% for each function we must provide the type and names of parameters
% parameter names much match those used in the xml_generateattacks.m file
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rowcol(fid,P,i,tstvec)
insertdata(fid,P.GEOMETRIC_TYPE,{P.PARAMS_ROWS P.PARAMS_COLS});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function nulineremove(fid,P,i,tstvec)
rowcol(fid,P,i,tstvec); % same as row col

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function flip(fid,P,i,tstvec)
	fprintf(fid,'\t<type ref="%s"/>\n','geometric');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 function cropping(fid,P,i,tstvec)
 insertdata(fid,'geometric',{'percentcropped'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotation(fid,P,i,tstvec)
 insertdata(fid,'geometric',{'angle'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotationscale(fid,P,i,tstvec)
rotation(fid);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function scale(fid,P,i,tstvec)
 insertdata(fid,'geometric',{'scale'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function shearing(fid,P,i,tstvec)
 insertdata(fid,'geometric',{'xshear','yshear'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ratio(fid,P,i,tstvec)
 insertdata(fid,'geometric',{'xscale','yscale'}); 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linear(fid,P,i,tstvec)
  insertdata(fid,'geomteric',{'T11','T12','T21','T22'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sharpening(fid,P,i,tstvec)
  insertdata(fid,'filtering',{'window'});

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function reducecolor(fid,P,i,tstvec)
  insertdata(fid,'colorreduce',[]);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fmlr(fid,P,i,tstvec)
 insertdata(fid,'filtering',[]);

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gaussian(fid,P,i,tstvec)
 insertdata(fid,'filtering',{'window'});

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function medfilt(fid,P,i,tstvec)
 insertdata(fid,'denoise',{'window'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hardthresh(fid,P,i,tstvec)
medfilt(fid);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function softthresh(fid,P,i,tstvec)
medfilt(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wiener(fid,P,i,tstvec)
medfilt(fid);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dpr(fid,P,i,tstvec)
% same as config for hardthresh
medfilt(fid);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dprcorr(fid,P,i,tstvec)
medfilt(fid);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stirmark(fid,P,i,tstvec)
insertdata(fid,'geometric',[]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function midpoint(fid,P,i,tstvec)
insertdata(fid,'denoise',{'windowsize'});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function trimmedmean(fid,P,i,tstvec)
midpoint(fid);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function templateremove(fid,P,i,tstvec)
stirmark(fid);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function collage(fid,P,i,tstvec)
insertdata(fid,'geometric',{P.PARAMS_COLLAGETYPE});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function jpegcompression(fid,P,i,tstvec)
insertdata(fid,P.COMPRESSION_TYPE);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function waveletcompression(fid,P,i,tstvec)
insertdata(fid,P.COMPRESSION_TYPE);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function projective(fid,P,i,tstvec)
insertdata(fid,'geometric',{'angle','axis','distfac','radiusfac'});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function warp(fid,P,i,tstvec)
insertdata(fid,'geometric',{'warpfactor'});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function copy(fid,P,i,tstvec)
insertdata(fid,'protocol');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sampledownup(fid,P,i,tstvec)
insertdata(fid,'geometric',{'downsample','upsample'});
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dither(fid,P,i,tstvec)
insertdata(fid,P.COLORREDUCE_TYPE,[]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function thresh(fid,P,i,tstvec)
insertdata(fid,P.COLORREDUCE_TYPE,[]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dprautoc(fid,P,i,tstvec)
insertdata(fid,P.DENOISE_TYPE,[]);



