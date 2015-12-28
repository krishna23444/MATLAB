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
function []=xml_WriteAttacks(dum1);
% writes the xml file to convert image file names into a standardized format
% uses function [imppm,vals]=getstirim(imtype,timnum,tstval,type2,slow1)
dum=[]
fname1='AttackList.xml'
imtype='xml';  % This justs sets the directory to nothing useful for manipulating the filenames
slow1=1; % All tests
timnum=1
P=getparams('testvalues');

fid=fopen(fname1,'w')
fprintf(fid,'<?xml version="1.0"?>\n');
fprintf(fid,'<listOfAttacks>\n');
% loop over all values of compression for all attacks
compressiontype='J';
sprintf('generating list of attacks with JPEG compression')
%for val=[10:10:100]
for val=[10 15 25 30 40 50 60 75 80 85 90 100] % stirmark3.0 values
%for val=[90]
  val
  compressionquality=getSubjectiveQuality(P,val,compressiontype);
  xml_generateattacks(fid,P,compressiontype,val,compressionquality);
end
compressiontype='W'
sprintf('generating list of attacks with wavelet compression')
%wavelet
for val=[8 3.5 1.5 0.8 0.6 0.5 0.4 0.3 0.2 0.1]
%for val=[1 0.6]
  val
  compressionquality=getSubjectiveQuality(P,val,compressiontype);
  xml_generateattacks(fid,P,compressiontype,val,compressionquality);
end
fprintf(fid,'\n\n</listOfAttacks>\n');
fclose(fid);
return;
