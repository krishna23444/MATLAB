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
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madue�o, St�phane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001.
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
function []=xml_APP_Stirmark3_0(fid,P)
 GAUSSIAN='gaussian';MEDIAN='medfilt';FMLR='fmlr';SHARPENING='sharpening';
 COMPRESSION='compression';CROPPING='cropping';SCALE='scale';
 CLABEL1='jpegorwavelet';CLABEL2='compressionFactor';CLABEL3='subjectiveCompressionQuality';
JPEG='J';WAVELET='W';
ATTACKTYPE='attackType';VAL='value';
ATTACKCLASS='attackClass';

 fprintf(fid,'\t<description>'); 
 fprintf(fid,'This approximates Fabien Petitcolas generation of results with Stirmark 3.0 \n');
 fprintf(fid,'see http://www.cl.cam.ac.uk/~fapp2/watermarking/benchmark/experiments/Result_table_II.xls\n');
 fprintf(fid,'for the results generated by him.');
 fprintf(fid,'</description>\n\n');
 groupcount=1;groupweight=1;
G=getparams('testvalues');
 %%%%%%%%%%%%%%%%%%%%%%%%%%% FILTERING %%%%%%%%%%%%%%%%%
 groupweight=1;
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Filtering');
 labels={CLABEL1 CLABEL2};weight=1;% weight of attakcs in the group
 refs(1).value=JPEG; refs(2).value='100.0';
 for attack={GAUSSIAN FMLR SHARPENING}
   insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
 endgroup(fid,'attackGroup'); 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%% COMPRESSION %%%%%%%%%%%%%%%%%
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Compression');
 weight=1;  labels={CLABEL1 CLABEL3 CLABEL2};
 refs(1).value=JPEG; jpegstr=' ';
 for jpegval=[10 15 25 50 60 75 80 85 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr; refs(3).value='100.0';
 for attack={COMPRESSION}
    insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
 endgroup(fid,'attackGroup'); 

  %%%%%%%%%%%%%%%%%%%%%%%%%%% CROPPING %%%%%%%%%%%%%%%%%
  [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Cropping');
 weight=1;  labels={CLABEL1 CLABEL2 'percentcropped'};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
  
 refs(2).value=jpegstr;str1=' ';
 for percentcropped=[1 2 5 10 15 20 25 50 75]; % cropping values used in stirmark 3.0
	 str1=sprintf('%s %d',str1,percentcropped);
 end
 refs(3).value=str1;
 for attack={CROPPING}
  insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
 endgroup(fid,'attackGroup'); 
  %%%%%%%%%%%%%%%%%%%%%%%%%%% SCALING %%%%%%%%%%%%%%%%%
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Scaling');
 weight=1;  labels={CLABEL1 CLABEL2 SCALE};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for vec=[0.5 0.75 0.9 1.1 1.5 2]; % scaling values used in stirmark 3.0
	 str1=sprintf('%s %1.2f',str1,vec);
 end
 refs(3).value=str1;
 for attack={SCALE}
     insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
 endgroup(fid,'attackGroup'); 
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%% SHEARING %%%%%%%%%%%%%%%%%
  [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Shearing');
 weight=1;  labels={CLABEL1 CLABEL2 'xshear'};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for vec=[1 10]; % scaling values used in stirmark 3.0
	 str1=sprintf('%s %1.2f',str1,vec);
 end
 refs(3).value=str1;
 for attack={'shearing'}
     insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
 % same for yshear
 weight=1;  labels={CLABEL1 CLABEL2 'yshear'};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for vec=[1 10]; % scaling values used in stirmark 3.0
	 str1=sprintf('%s %1.2f',str1,vec);
 end
 refs(3).value=str1;
 for attack={'shearing'}
     insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
  endgroup(fid,'attackGroup'); 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ROTATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Rotation');
 weight=1;  labels={CLABEL1 CLABEL2};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for attack={'rotation' 'rotationscale'}
        insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
    endgroup(fid,'attackGroup'); 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OTHER GEOMETRIC TRANSFORMATIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Other Geometric Transformations');
 weight=1;  labels={CLABEL1 CLABEL2};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[100 90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for attack={'rowcol' 'flip'}
         insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
  
  endgroup(fid,'attackGroup'); 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%RANDOM BENDING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'Random Geometric Distortions');
 weight=1;  labels={CLABEL1 CLABEL2};
 refs(1).value=JPEG; 
 jpegstr=' ';
 for jpegval=[90]; % JPEG values used in stirmark 3.0
	 jpegstr=sprintf('%s %1.1f',jpegstr,jpegval);
 end
 refs(2).value=jpegstr;str1=' ';
 for attack={'stirmark'}
            insert_attackGroup2(fid,attack,weight,labels,refs,'attackClass');
 end
  
  endgroup(fid,'attackGroup'); 