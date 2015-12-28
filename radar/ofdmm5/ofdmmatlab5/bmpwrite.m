function bmpwrite(X,map, filename);
%BMPWRITE Write a BMP (Microsoft Windows Bitmap) file to disk.
%	BMPWRITE(X,MAP,'filename') writes a BMP file containing the
%	indexed image X and colormap MAP to a disk file called 'filename'.
%	If no file extension is given with the filename, the extension
%	'.bmp' is assumed.
%
%	See also: BMPREAD, GIFWRITE, HDFWRITE, PCXWRITE, TIFFWRITE,
%	          XWDWRITE.

%	Mounil Patel 3/10/94
%	Copyright (c) 1994 by The MathWorks, Inc.
%	$Revision: 1.13 $  $Date: 1995/02/09 15:28:11 $

if (nargin~=3)
	error('Requires three arguments.');
end;

if (isstr(filename)~=1)
	error('Requires a string filename as the third argument.');
end;

if (isempty(findstr(filename,'.'))==1)
	filename=[filename,'.bmp'];
end;

fid=fopen(filename,'wb','l');
if (fid==-1)
	error(['Error opening ',filename,' for output.']);
end;

fwrite(fid,[66;77],'uchar');

[biHeight,biWidth]=size(X);
% What will be the physical file size?  First term: image data,
% with width padded to be multiple of 4.  Second term: length of
% bitmap header.  Third term: length of bitmap information
% header.  Third term: length of color palette.
bfSize = biHeight*(biWidth+(4-rem(biWidth,4))) + 14 + 40 + 256*4;
fwrite(fid,bfSize,'uint');
bfReserved1=0;
fwrite(fid,bfReserved1,'ushort');
bfReserved2=0;
fwrite(fid,bfReserved2,'ushort');
bfOffBytes=1078;
fwrite(fid,bfOffBytes,'uint');
biSize=40;
fwrite(fid,biSize,'uint');

fwrite(fid,biWidth,'uint');
fwrite(fid,biHeight,'uint');
biPlanes=1;
fwrite(fid,biPlanes,'ushort');
biBitCount=8;
fwrite(fid,biBitCount,'ushort');
biCompression=0;
fwrite(fid,biCompression,'uint');
biSizeImage=biHeight*(biWidth+(4-rem(biWidth,4)));
fwrite(fid,biSizeImage,'uint');
biXPels=0;
fwrite(fid,biXPels,'uint');
biYPels=0;
fwrite(fid,biYPels,'uint');
biClrUsed=256;
fwrite(fid,biClrUsed,'uint');
biClrImportant=0;
fwrite(fid,biClrImportant,'uint');

[m,n]=size(map);
if (m<256)
	map=[map;zeros(256-m,3)];
elseif (m>256)
 error('Colormap exceeds 256 colors! Only 8-bit BMP file output is supported.');
end;

map=[fliplr(map*255),zeros(256,1)]';
fwrite(fid,map(:),'uchar');

X=(X-1);
if (rem(biWidth,4)~=0)
	X=[X,zeros(biHeight,4-rem(biWidth,4))];
end;
X=rot90(X,3);
fwrite(fid,X(:),'uchar');

fclose(fid);

