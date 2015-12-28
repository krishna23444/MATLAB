function inserttd(fid,val)
opentag(fid,'td');
fprintf(fid,'  <div align="center"><font face="Arial, Helvetica, sans-serif">%s</font></div>',val);

