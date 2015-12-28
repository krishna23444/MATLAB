function TableElement(fid,element,attribval)


if iscell(element)
  element=element{1,1};   
  element=char(element);
end
if exist('attribval')~=1
  attribval=[];
end

if isempty(attribval)
  opentag(fid,'td');
  fprintf(fid,'<div align="center">%s</div></td>\n',element);
  return;
else
  if isfield(attribval,'link')
    attribval=attribval.link;
  end
  if ~isempty(attribval)
    opentag(fid,'td');fprintf(fid,'<div align="center"><b><font face="Arial, Helvetica, sans-serif">');
    insertlink(fid,char(attribval),element);
    closetag(fid,'font');  closetag(fid,'b');  closetag(fid,'div');  closetag(fid,'td');
  end
end
