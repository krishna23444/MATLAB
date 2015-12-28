function writeFig300dpi(figNo, fileName)
%make the backgroung white
set(figNo,'color','w');
f=getframe(figNo);
colormap(f.colormap);
imwrite(f.cdata, fileName, 'Resolution', 500)