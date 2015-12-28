function closetag(fid,tag)
fprintf(fid,'</%s>',tag);
fprintf(fid,'\n');