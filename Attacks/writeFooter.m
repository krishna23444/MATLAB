function writeFooter(fid)
fprintf(fid,'<table width="100%%" border="0" bgcolor="#CCCCFF">\n');
fprintf(fid,'  <tr> \n');
fprintf(fid,'    <td>&nbsp;</td>\n');
fprintf(fid,'  </tr>\n');
fprintf(fid,'</table>\n');
fprintf(fid,'<div><font face="Arial, Helvetica, sans-serif" size="-1">');
fprintf(fid,'Updated by ');
insertlink(fid,'http://vision.unige.ch/~pereira','Shelby Pereira')
fprintf(fid,': Results as of %s<BR>',date);
fprintf(fid,'</font> </div>\n');
