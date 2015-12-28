function writegentable(fid,numrows,numcols,line1,data,col1,corner1,attribvals,col1attribs)

if exist('col1')~=1
  col1=data(1:end,1);
  corner1=line1(1);line1=line1(2:end);
  data=data(:,2:end);
end
if exist('attribvals')~=1
  attribvals=cell(size(data));
end
if exist('col1attribs')~=1
  col1attribs=cell(size(col1));
end

% writes an html table into fid

fprintf(fid,'<font SIZE="1" face="VERDANA, Arial, Helvetica">\n');
fprintf(fid,'<table width="85%%" border="1" cellspacing="2" cellpadding="2" align="center">\n');
% First line
opentag(fid,'tr');
TableElement(fid,corner1);

for i=1:numcols
  TableElement(fid,line1(i));
end
closetag(fid,'tr');

% second:last-1 line
for j=1:numrows
    fprintf(fid,'<tr>\n');
 
    TableElement(fid,col1(j),col1attribs{j});
    % data for each group
    for i=1:numcols
      TableElement(fid,data(j,i),attribvals{j,i});
    end
    closetag(fid,'tr');
end
closetag(fid,'table');
closetag(fid,'font');