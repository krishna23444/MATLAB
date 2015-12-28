% %%%%%%%%%%%%%%%%%

function []=jasperCompress(imnamepgm,imname2,bpp,varargin)
% determine if we are using color or grayscale
ind=findstr(imnamepgm,'.ppm');
if isempty(ind)
  PGM=1;
else
  PGM=0;
end

% convert the pgmfile to JPEG2000 while compressing
% to bpp bits per pixel
%bpp=1;

rate1=1/(8/bpp);  % the compression ratio
% first convert from pnm to JPEG2000
com1=sprintf('!jasper -f %s -F tmp.jp2 -T jp2 -O rate=%1.3f',imnamepgm,rate1);
eval(com1);

% now convert the result to pnm

if PGM
  com2=sprintf('!jasper --input tmp.jp2 --output tmpjp2.pgm -T pnm');
else %PPM
  com2=sprintf('!jasper --input tmp.jp2 --output tmpjp2.ppm -T pnm');
end

eval(com2);

% now read it in and save as JPEG
if PGM
  im=pgmread('tmpjp2.pgm');
else
  [R,G,B]=ppmread('tmpjp2.ppm');
  im=[];im(:,:,1)=R;im(:,:,2)=G;im(:,:,3)=B;
end

imwrite(uint8(im*255),imname2,'Quality',100);
