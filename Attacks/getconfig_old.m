% the main function clal this function to setup paths and variables
% customize according to local configuration

function SETUP=getconfig(dum)

% Modify the variables checkmarkPath, imagepath and WMimageName 
% These represent the path to the checkmark package, the
% path to the watermarked images and the watermarked image names respectively.
% applicname can also be modified to generate results for different applications
% by default copyrightProtection is used, however results for banknote and nongeometric 
% can be generated from the copyright protection result file since these are just subsets of the
% copyright protection application

% modify this path to the path where the program is installed
checkmarkPath='c:\shelby\matlab\benchmarking\Checkmark\';

% MATLAB 5.3 users should use P=genpath(checkmarkPath,0)
% MATLAB 6.0 must leave out the second parameter
P=genpath(checkmarkPath);
path(path,checkmarkPath);path(path,P);
SETUP.checkmarkPath=checkmarkPath;

% The path with the watermarked images
% Note that the attacked images will be stored in imagepath\SETUP.attackedsubdir
% MUST end with a slash!!!
SETUP.imagepath='C:\shelby\matlab\dct_realtim2\';

% an EMPTY directory should be used for the attacked images
SETUP.attackedsubdir='ATTACKED2';

% possible applications available in the current version
% each of these have a corresponding .cfg which contains the parameters for the application
% DO NOT include .cfg in the file name

%SETUP.applicname={'copyrightProtection'};
%SETUP.applicname={'banknote'};
%SETUP.applicname={'nongeometric'};
% multiple names should be used only when running the script parseresults.m
% this is useful for generating tables with multiple technologies/applications
SETUP.applicname={'nongeometric' 'copyrightProtection' 'banknote'};

% the number of watermarked images to attack
SETUP.numims=5;

% the base name of the orignal and watemraked image.  
% The actual names include the extension 1.jpg,2.jpg...numims.jpg.  
% DO NOT INCLUDE '.jpg' in the name.  Original and watermarked images should be
% numbered sequentially 1..numims, all should be in the imagepath directory
% note that the original images are needed only for calculating quality metrics

SETUP.origImage='im';
SETUP.WMimage='imWM';

% the name of the technology, the results will be stored in application_techname.xml in the checkmarkPath 
% this is done so that the parseresults script can be run easily.  
% The xsl doesn't seem to work with arbitrary paths so by default we put all the xml stuff in the
% checkmark directory and run the parsing from there
%  the name should NOT contain the extension or the directory!!
% for the submission of xml files the names in the table have the format
% techname_numbits   

%SETUP.techname={'unige2000_56'};
% multiple names should be used only when running the script parseresults.m
% this is useful for generating tables with multiple technologies/applications
%SETUP.techname={'unige1999_64'  'frid2_1' 'dugad_1' 'bruyn_1' 'xie_1' 'unige2000_56'} ;
SETUP.techname={'cox_1','kim_1','wang_1','xia_1'} ;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the following parameters are used for generating tables in html format
% see the file parseresults.m also

% Name of the main HTML page
SETUP.mainHTMLpage='index.html';

% The path where the HTML files will be written
SETUP.HTMLPATH= 'D:/checkmark_tables/';

% Base link for html tables, all links are relative to this one
% typically the same as HTMLPATH, but can be useful if we want to later post on the web
SETUP.HTML_BASEHREF='http://watermarking.unige.ch/checkmark/Results/Non_Blind/';
%SETUP.HTML_BASEHREF='file:///D:/checkmark_tables/';

% location of the checkmark images for the background and header
% these can be copied from the /images directory to the website
% if using netscape with a diretory (not a website) use  file:/// before the path

%SETUP.HTML_IMAGES_PATH='file:///D:/images/';
SETUP.HTML_IMAGES_PATH='http://watermarking.unige.ch/checkmark/';

% path to the JAR files xalan and xerces.  These are included in the JARS.zip package
% from the checkmark website. MUST end with backslash
SETUP.JARSPATH='c:\JARS\';

