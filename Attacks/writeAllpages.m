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

function writeAllpages(technologies,applications,mainTable)

global HTML_OUTPUT_PATH;
global IMAGES_PATH;
global DATA_PATH;

%create_dir_result = mkdir(HTML_OUTPUT_PATH)


fname=[HTML_OUTPUT_PATH,mainTable]
fid=fopen(fname,'w');
if fid==-1
  sprintf('unable to open file in directory')
 HTML_OUTPUT_PATH
  sprintf('make sure directory exists!!')
  sprintf('TERMINATING')
  return
end

writeheader(fid);
insertcomments(fid,'techapp')

%technologies={'digimarc'}
%applications={'banknote' }
row=1;
m=size(technologies,2);n=size(applications,2);
datacell=cell(m,n);
attribval=cell(m,n);
applicline=applications;
filenames=dir;
b=strvcat(filenames(:).name);applicline2=applicline;

sprintf('outputting results for the following applications')
applications
for technology=technologies
  col=1;  count=0;
  for application=applications
    resultfname=[char(technology) '_' char(application) '.xml']
    count=count+1;
    datafile=[char(technology) '_' char(application) '.txt']
    if ~isempty(strmatch(datafile,b,'exact'))
      [percentD,numims,numattacks]=baseAppTechPage(datafile,char(technology),char(application));
      str2=sprintf('(%d,%d)',numims,numattacks);
      applicline2(count)=strcat(applicline(count),str2);
      str1=[num2str(percentD) '%'];
      datacell{row,col}=str1;
      attribval{row,col}.link=[char(technology) '/' char(technology) '_' char(application) '.html'];
    else
      datacell{row,col}='NA';
    end
    col=col+1;
  end
  col1attribs{row}.link=[char(technology) '.html'];
  row=row+1;flag=0;
end


writegentable(fid,m,n,applicline2,datacell,technologies,'TECH_bits/APP(images,attacks)',attribval,col1attribs);
writeFooter(fid);
closepage(fid);
fclose(fid);

