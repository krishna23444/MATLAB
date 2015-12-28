function imout=imclip(imin)
imout=imin;
imout(find(imout<0))=0; 
imout(find(imout>255))=255;
