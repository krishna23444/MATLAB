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

DOALL=1;
sprintf('setting up path')
checkmarkPath='c:\shelby\matlab\Benchmarking\Checkmark\';
P=genpath(checkmarkPath);
Path(Path,checkmarkPath);Path(Path,P);

if DOALL==1
    sprintf('writing file of all attacks')
    xml_WriteAttacks    
    sprintf('writing file of all attack classes')
    xml_WriteAttackClass
else
    fprintf('skipping writing of attacks and classes, set DOALL to 1 if required...')
end


% applicname='Stirmark3_0';%  applicname='allattacktest';
% generate the following applications
% there must be a function called xml_APP_applicname.m which defines the application 
applics={'banknote' 'copyright' 'nongeometric'}

%applics={'medical' 'logo' 'video'}
%applics={'banknote' 'copyright' 'nongeometric' 'medical' 'logo' 'video'}
for applicname=applics
  applicname=char(applicname);
  fname1=sprintf('%s.xml',applicname);
  
  % the file applicxml is used to generate the results in html format
  % later
  
  applicxml=strcat('result_',fname1); 
				      
  sprintf('writing config file for application %s',applicname)
  xml_WriteApplication(applicname,fname1);

  % run the scripts to generate the config file
  sprintf('generating configuration file')
  configFname=sprintf('%s.cfg',applicname);
  com1=sprintf('!xalan -in %s -xsl createAppFile.xsl -out %s',fname1,applicxml);
  eval(com1);
  com2=sprintf('!java -classpath c:\\JARS\\xalan.jar;c:\\JARS\\xerces.jar  org.apache.xalan.xslt.Process -in %s -xsl createMatlabConfig.xsl -out %s',applicxml,configFname)
  eval(com2);
  
end 

% the .cfg files and the file result_applicname.xml should be moved to th
% checkmark directory,  I haven't included it in the script so as to avoid 
% accidently deleting configuration files