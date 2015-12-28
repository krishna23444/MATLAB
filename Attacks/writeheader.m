function a = writeheader(fid, technology, application,baseref)
% writeheader Writes the default header for the checkmark files.
%
% Written by Vladimir Calderon
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
global BASEHREF

if exist('baseref')~=1
  baseref=BASEHREF;
end

fprintf(fid,'<!doctype html public "-//w3c//dtd html 4.0 transitional//en">\n');
% fprintf(fid,'<html><!-- #BeginTemplate "/Templates/checkmark_model.dwt" -->\n');
fprintf(fid,'<BASE HREF="%s">',baseref);
fprintf(fid,'<head>');
fprintf(fid,'   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\n');
fprintf(fid,'   <meta name="Author" content="shelby pereira">\n');
fprintf(fid,'   <meta name="GENERATOR" content="Mozilla/4.7 [en] (WinNT; U) [Netscape]">\n');
fprintf(fid,'<meta name="keywords" content="checkmark image video signal audio MP3 MPEG2 watermark benchmark shelby pereira quality metric result results stirmark wavelet compression watson noise visibility">\n');
%fprintf(fid,'<!-- #BeginEditable "doctitle" -->\n');
fprintf(fid,'<title>CHECKMARK</title>\n');
%fprintf(fid,'<!-- #EndEditable -->\n');
fprintf(fid,'</head>\n');
fprintf(fid,'<body background="%sbackground.gif">\n',IMAGES_PATH);
%fprintf(fid,'<CENTER>\n');
%fprintf(fid,'  <p><a href="http://watermarking.unige.ch/Checkmark"><img SRC="%scheckmark_bg.gif" height=132 width=600 border="0"></a></p>\n',IMAGES_PATH);
%fprintf(fid,'  <table width="100%%" border="0" bgcolor="#CCCCFF" height="1%%">\n');
%fprintf(fid,'    <tr>\n');
%fprintf(fid,'      <td width="839">&nbsp;</td>\n');
%fprintf(fid,'    </tr>\n');
%fprintf(fid,'  </table>\n');
%fprintf(fid,'  </CENTER>\n');

vnum=checkmarkversion(0);
insertlink(fid,'http://watermarking.unige.ch/Checkmark/','<B>Checkmark ');
fprintf(fid,' version %s </B> <BR>',vnum);

if exist('technology')==1
  techapp(fid,technology,application,baseref);
else
  opentag(fid,'center');opentag(fid,'p');
  fprintf(fid,'Technology/Application Summary table');
  closetag(fid,'center');closetag(fid,'p');
  fprintf(fid,'N/A indicates that data is unavailable, or the technology is not applicable to the application<BR>');
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function a=techapp(fid,technology,application,htmlpath)
% Printing Technology and application
P1=getconfig(0);
opentag(fid,'CENTER');
fprintf(fid,'<div>\n<font face="Arial, Helvetica, sans-serif"><b>\n');
insertlink(fid,[P1.HTML_BASEHREF P1.mainHTMLpage],'Technology'); 
fprintf(fid,': %s ; ',technology);
link=[P1.HTML_BASEHREF technology '/' technology '_' application '.html'];
text1=sprintf('Application: %s',application);
insertlink(fid,link,text1);
fprintf(fid,'</b></font></div>\n');
closetag(fid,'CENTER');
a = 1;