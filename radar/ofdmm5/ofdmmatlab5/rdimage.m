function [datatx,h,w] = rdimage(filename,PictureComp)
%RDIMAGE Reads a grey scale bmp file, suitable for cofdm transmission
%	datatx = rdimage(filename,PicutreComp)
%	filename is the filename of the bmp file to load.
%
%	PictureComp : Picture intensity compression. Fraction to 
%		compress the intensity of the image by. This is
%		compresses the images so whites are darker and black
%		is lighter. This is to modify the mapping of the final
%		transmission mapping when using 256PSK. It increases 
%		the gap between black and white, to help prevent
%		wrap around of black to white, in a noisy channel.
%		Note : This is an optional parameter with a default
%		setting of 1, giving no compression.
%		
%	datatx : 8bit words representing the intensity of each pixel.
%		The output data is in a byte serial format, in a single row.
%
%	h : height of image in pixels
%	w : width of the image in pixels

%================================
%	Used functions:
%	bmpread.m
%=====================
%	Modified:
%	31/7/97	8:20am	rdimage.m
%	Started work on the function
%
%	31/7/97 12:00pm rdimage.
%	Fixed a bug with the ordering of the bits. The conversion
%	to base 4,2,or 1 was causing the image to be incorrect.
%	It had repetitions of the picture, each successively getting
%	smaller, in an binary tree type arrangment. This was due
%	to the msb => lsb being placed on separate symbols, but
%	being recreated assumming they were side by side on the same 
%	symbol. The effect can be recreated by rotating leftover, and
%	FileData using the ' operation.
%	rdfile.m appears to work now.
%
%	31/7/97	3:00pm	rdimage.m
%	The check for if the map and gray colors are the same keeps
%	on having wierd errors, so I commented them out.
%
%	3/8/97	10:30am	rdimage.m
%	Added the PictureComp parameter to allow for varying the 
%	mapping to help prevent roll over of black to white. Also added
%	data averaging allowing duplicate data to be sent to reduce the
%	error rate.
%	
%	12/8/97	7:30pm	rdimage.m
%	Removed the DataAvg parameter as this is now done by the transmit 
%	function. Also removed the number base conversion, and the formatting
%	of the data into symbols. All these are now done by the transmit routine.

[x,map] = bmpread(filename);
x=x-1;		%Change from 1-256 to 0-255;
if nargin == 2,
	%x=round((x/PictureComp)+(PictureComp-1)*128);
	x = round((x-128)/PictureComp+128);
end

%if map ~= gray,
%	error('The bmp to be loaded is not a gray scale image');
%end
h = size(x,1);
w = size(x,2);

datatx = reshape(x',1,h*w);	%Put the data in a serial byte format