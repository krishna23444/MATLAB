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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% This script generates all the attacked images
%  the following applications are available, note that banknote and nongeometric are subsets of copyright
% results for all applications can be generated from the copyrightProtection results

SETUP=getconfig(0);imagepath=SETUP.imagepath;applicname=SETUP.applicname;

configFname=sprintf('%s.cfg',char(applicname));
% create the output directory if necessary
subdirname=SETUP.attackedsubdir;

% OutDir must end with a slash!!!
outDir=sprintf('%s%s\\',imagepath,subdirname);


status=mkdir(imagepath,subdirname);

save impaths imagepath outDir configFname

i=1;numims=SETUP.numims;
while i<=numims % the number of images
  % I think there are some memomry leaks in the matlab griddata function
  % this is just a hack to be able to recover memory
  % the program does not run to completion without this on my system
  % add the following code if memory problems exist 
  %  save statei i numims
  %  clear all
  %  pack
  %  load statei
  %  load impaths
  %%%%%%%%% end of hack %%%%%%%%%%%%%%%%%%
  % run all attacks on a set of watermarked images
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % NAME OF WATERMARKED IMAGES, MUST BE CUSTOMIZED!!!
  
  WMimageName=[imagepath SETUP.WMimage int2str(i) '.jpg']
  
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  imin=double(imread(WMimageName));

  %  figure;imagesc(imin);colormap gray; colorbar;drawnow
  
  % base name for the output files start with the directory\im# 
  baseName=sprintf('%sim%d',outDir,i)
  % generate and store attacks, the main function call
  checkmark(imin,configFname,baseName);
  i=i+1;
end

disp([' *********customize and run the script testDetector.m to produce the***'])
disp([' ********* results in XML format***'])
% results in XML format

