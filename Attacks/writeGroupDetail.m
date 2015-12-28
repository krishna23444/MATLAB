function writeGroupDetail(AIN,R,params,values,Ctype, Iorig,Gorig, images, groups, technology, application);

% produces the html tables for the individual attack groups
% Written by Shelby Pereia
%
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
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
global HTML_OUTPUT_PATH;
global IMAGES_PATH;
global BASEHREF;

path1 = [HTML_OUTPUT_PATH,technology,'/'];
numgroups=size(groups,1);
numims=length(images);
maxparams=100;maxattacks=100;
datacell=cell(maxattacks,numims+maxparams);
line1=cell(1,numims+maxparams);
for i=1:numgroups

  fname=[path1,application,'_' ,char(groups(i)),'.html'];
  sprintf('generating file %s',fname)
  fid = fopen(fname,'w');
  baseref=[BASEHREF technology '/'];
  writeheader(fid, technology, application,baseref);
  opentag(fid,'CENTER')
  fprintf(fid,'<BR>Detailed results for the %s  group\n',char(groups(i)));closetag(fid,'CENTER');


  inds1=strmatch(groups(i),Gorig,'exact');numparams=1;
  inds2=strmatch(images(1),Iorig(inds1));

  %    inds2 contains the indices of the image(j) belonging to group i
  P1=params(inds1,:);    VALS=values(inds1,:);compression=Ctype(inds1);
  P1=P1(inds2,:);    VALS=VALS(inds2,:);compression=compression(inds2,:);

  % print first line of table
  line1{1,1}='CType';
  VALS=[VALS,-99999*ones(size(VALS,1),1)];
  while ((VALS(inds2(1),numparams)>-999))
    line1{1,numparams+1}=P1(1,numparams+1);
    numparams=numparams+1;
  end
  line1{1,2}='CFactor';
  for j=1:numims
    tmp1=char(images(j));
    line1{1,numparams+j}=tmp1;
  end
  
  P1=params(inds1,:);VALS=values(inds1,:);compression=Ctype(inds1);
  P0=P1(inds2,:);VALS0=VALS(inds2,:);compression0=compression(inds2);
  [dum,inds3]=sort(VALS0(:,1)); % sort by compression factor
  P0=P0(inds3,:);compression0=compression(inds3);VALS0=VALS(inds3,:);
  col1=AIN(inds1);col1=col1(inds2);col1=col1(inds3);
  % extract the first part of the name (before the underscore)
  for L=1:size(col1,1)
    tmp=col1{L};
    col1{L}=strtok(tmp,'_');
  end
  
  for k=1:length(inds2)
      % fill in results for parameter values
%      compression0(k)
      datacell{k,1}=compression0(k);
      for j=1:numparams-1
	datacell{k,j+1}=num2str(VALS0(k,j),'%1.2f');
	tmp=VALS0(k,j);
      end
      
      for j=1:numims
	% fill in results for images
	inds2=strmatch(images(j),Iorig(inds1));
	Results1=R(inds1); Results1=Results1(inds2);
	Results1=Results1(inds3);
	datacell{k,j+numparams}=num2str(Results1(k),'%1.0f');
      end
    end  
  numrows=length(inds2);numcols=numims+numparams;
  writegentable(fid,numrows,numcols,line1,datacell,col1,'SubGroup');

  insertcomments(fid, char(groups(i)));
  opentag(fid,'p')
  fprintf(fid,'Note: CFactor=Quality factor for JPEG (J) and bits per pixel for wavelet (W) \n');closetag(fid,'p');
  writeFooter(fid);
  closepage(fid);  
  fclose(fid);
end
