function x = wrimage(DataOut,h,w,filename,PicExpand)
%WRIMAGE Formats the data and writes it to a bmp file
%
%	x = wrimage(DataOut,h,w,filename,PicExpand)
%	x : image data as a single row vector. The data should be in the form of
%	a raster scan, e.g. rows of pixels (must have h*w elements)
%	h : height of image in pixels
%	w : width of image in pixels
%	filename : filename of file to store the image in .bmp format
%	PicExpand : Picture decompression of the amplitude.
%		Fractional factor to expand the amplitude of the
%		received image. This is used to over come roll over
%		errors from black to white when sending data 8bits/word.
%		This parameter is typically equal to the compression
%		applied using the PictureComp parameter in the rdimage
%		function
%		Note : This is an optional parameter. With the default of
%		no image expansion.
%
%	See RDIMAGE
%
%	Copyright (c) Aug 1997
%

%=================================
%	Required External Funtions
%	bmpwrite.m
%=================================
%	modified:
%	17/6/97	Initial rewrite up of the function. Some testing has been done.
%
%	31/7/97	8:52	wrimage.m
%	Modified wrfile so that it writes a bmp file from the data
%	
%	31/7/97 12:31	wrimage.m
%	wrimage is finished and works.
%
%	3/8/97	9:50am	wrimage.m
%	Added the PicExpand parameter for modifing the amplitude mapping
%	of the received image.
%
%	12/8/97 7:30pm	wrimage.m
%	Removed the number base conversion of the data.

x=reshape(DataOut,w,h)';

%==========================
%Expand the image intensity
%==========================
if nargin == 5,
	%x=round((x-(PicExpand-1)*128)*PicExpand); 
	x=round((x-128)*PicExpand+128);

end

%==============
%Save the image
%==============
bmpwrite(x,gray,filename);

