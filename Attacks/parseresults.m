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
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.


%  Parsing the results is a 2 stage process
% first we call an xsl file to extract the results as a function of application
% then we call the matlab routing generateTables.m to generate the HTML tables

SETUP=getconfig(0);

% modify the variables below to correspond to the name of the technology results file
% the parentheses are necessary!!!

technologies=SETUP.techname;
applications=SETUP.applicname;

% note that if results for more than one technology or application are available 
% the syntax below can be used,

% technologies={'CUI2000' 'CUI2001'}
% applications={ 'nongeometric' 'copyrightProtection' 'banknote'}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XSL parsing
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jp=SETUP.JARSPATH;
filenames=dir;
b=strvcat(filenames(:).name);

for technology=technologies
technology
  for application=applications
    resultfname=[char(technology) '_' char(application) '.xml']
    if ~isempty(strmatch(resultfname,b,'exact'))
      xmlapplic=['result_' char(application) '.xml']
      resultOut=[char(technology) '_' char(application) '.txt']
      com1=['!java -classpath ' jp 'xalan.jar;' jp 'xerces.jar org.apache.xalan.xslt.Process ']; 
      com2=[com1 ' -in ' resultfname ' -xsl createMatlabTechRes.xsl -param appFileUrl \"' xmlapplic '\" -out ' resultOut]
      eval(com2);                    
    end
    
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end of XSL pre-parsing %%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now customize the global variables
% to generate the HTML tables

global HTML_OUTPUT_PATH
global DATA_INPUT_PATH
global IMAGES_PATH
global BASEHREF

% Name of the main HTML page
mainPageName=SETUP.mainHTMLpage;

% the html tables are first written to HTML_OUTPUT_PATH then copied to the final website
% HTML_OUTPUT_PATH ***MUST*** end with a slash!!!!
HTML_OUTPUT_PATH    =SETUP.HTMLPATH

% Base link for html tables
BASEHREF=SETUP.HTML_BASEHREF;

DATA_INPUT_PATH=SETUP.checkmarkPath;

% the checkmark images must be in the IMAGES_PATH directory
% copy the checkmark/images directory to IMAGES_PATH
IMAGES_PATH = SETUP.HTML_IMAGES_PATH;

writeAllpages(technologies,applications,mainPageName);

% copy pages to final destination
% this may not be necessary systems which are running the test on windows and copying to
% a unix file system my have to do this

if exist('SETUP.HTML_FINALPATH')==1
  a1=pwd;
  FINAL_PATH=SETUP.HTML_FINALPATH;
  com1=sprintf('cd %s',  HTML_OUTPUT_PATH(1:end-1))
  eval(com1)
  
  com1=['!xcopy * '  FINAL_PATH ' /E /Y /I']
  eval(com1)
  com1=['cd ' a1]
  eval(com1)
end
