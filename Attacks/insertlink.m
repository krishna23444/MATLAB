function insertlink(fid,link,text1)

fprintf(fid,'<a href="%s">%s',link,text1);closetag(fid,'a');