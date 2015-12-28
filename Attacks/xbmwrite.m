function xbmwrite(varargin)
%XBMWRITE Write a XBM (X bitmap) file to disk.
%
%   XBMWRITE(X,MAP,'FILENAME') writes a XBM file containing the indexed
%   image X and colormap MAP to the file 'FILENAME'.
%
%   XBMWRITE(I,'FILENAME') writes a XBM file containing the black and
%   white image in the matrix I to the file 'FILENAME'.
%
%   If file name has no suffix, '.xbm' is used.
%
%   See also: XBMREAD.

%   Author:      Peter J. Acklam
%   Time-stamp:  1998-05-22 21:21:33
%   E-mail:      jacklam@math.uio.no (Internet)
%   WWW URL:     http://www.math.uio.no/~jacklam

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check number of input arguments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

error( nargchk( 2, 3, nargin ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identify input arguments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 2                  % XBMWRITE(I,'FILENAME')
   I         = varargin{1};
   filename  = varargin{2};
   isindexed = 0;
else                            % XBMWRITE(X,MAP,'FILENAME')
   X         = varargin{1};
   map       = varargin{2};
   filename  = varargin{3};
   isindexed = 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is no longer needed, so delete to save memory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear varargin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check filename.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~ischar(filename) | isempty(filename)
   error( 'File name must be a non-empty string' );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get file base name and add suffix to file name if necessary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = find( filename == '.' );
if isempty( k )
   filebase = filename;
else
   filebase = filename;
   filebase(k) = '_';
   filebase = filebase( 1 : max(k)-1 );
end
filename = [ filebase '.xbm' ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open output file for writing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen( filename, 'w' );
if ( fid == -1 )
   error( [ 'Can''t open file ''' filename ''' for writing.' ] );
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get dimension of image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isindexed
   [ rows, cols ] = size( X );
else
   [ rows, cols ] = size( I );
end
pixels = rows*cols;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write file header.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf( fid, '#define %s_width %d\n', filebase, cols );
fprintf( fid, '#define %s_height %d\n', filebase, rows );
fprintf( fid, 'static char %s_bits[] = {\n', filebase );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write image. Colour images are first converted to grayscale.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbytesi = ceil( cols/8 );       % Num of bytes needed for each image row.
bitsw   = 8*nbytesi;            % Bits needed for each image row.
powtwo  = pow2( 0:7 );          % Needed for converting bits to bytes.
nbytesf = 14;                   % Num of bytes on each line in the file.

w = [ 0.298936 ; 0.587043 ; 0.114021 ];
format = [ ' ' repmat( '0x%.2x,', 1, nbytesf ) '\n' ];

data = zeros( nbytesi, rows );
for row = 1:rows

   % Convert to ones (black) and zeros (white).
   if isindexed
      bits = 1 - round( map(X(row,1:cols),:)*w );
   else
      bits = 1 - round( I(row,1:cols) )';
   end

   % Padd zeros so the number of bits become a multiple of eight.
   padded_bits = zeros( 8, nbytesi );
   padded_bits(1:cols) = bits;
      
   % Convert from bits to bytes and store.
   bytes = powtwo*padded_bits;
   data(:,row) = bytes';

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write data to file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf( fid, format, data(1:end-1) );
if rem( nbytesi * rows, nbytesf ) == 1
   fprintf( fid, ' 0x' );
end
fprintf( fid, '%.2x};\n', data(end) );

fclose( fid );          % Close file.
