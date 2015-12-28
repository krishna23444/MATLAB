function [X,map] = xbmread(filename)
%XBMREAD  Read a XBM (X bitmap) file from disk.
%
%   I = XBMREAD( 'FILENAME' ) reads the file 'FILENAME' and returns the
%   intensity image I.
%
%   [X,MAP] = XBMREAD('FILENAME') reads the file 'FILENAME' and returns
%   the indexed image X and associated colormap MAP.
%
%   If file name has no suffix, '.xbm' is used.
%
%   See also: XBMWRITE.

%   Author:      Peter J. Acklam
%   Time-stamp:  1998-05-22 20:35:46
%   E-mail:      jacklam@math.uio.no (Internet)
%   WWW URL:     http://www.math.uio.no/~jacklam

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check number of input arguments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

error( nargchk( 1, 1, nargin ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identify output arguments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nargsout = nargout;
if nargsout == 1
   isindexed = 0;
elseif nargsout == 2
   isindexed = 1;
else
   error( 'Wrong number of output arguments.' );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check filename.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~ischar( filename ) | isempty( filename )
   error( 'File name must be a non-empty string' );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add suffix to file name if necessary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k  = [ find( filename == filesep ) ];
if isempty(k)
   k = 0;
else
   k = max(k);
end
if all( filename(k+1:end) ~= '.' )
   filename = [ filename '.xbm' ];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open input file for reading.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen( filename, 'r' );
if ( fid == -1 )
   error( [ 'Can''t open file ''' filename ''' for reading.' ] );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read image size.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

width = 0;
height = 0;
x_hot = 0;
y_hot = 0;

% Read lines until we find one that starts with the word "static".
found_static = 0;
while ~found_static

   line = getline( fid );
   [ token, line ] = strtok( line );
   if strcmp( token, 'static' )
      break
   end

   %
   % Scan file for definition of image width and height. It should look
   % something like, for instance,
   %
   %   #define imagename_width  48
   %   #define imagename_height 32
   %

   %
   % Read lines until we find a "#define" directive. The ANSI standard
   % allows whitespace between newline and "#" and between "#" and
   % "define".
   %
   found_define = 0;
   if strcmp( token, '#define' )
      found_define = 1;
   elseif strcmp( token, '#' )
      [ token, line ] = strtok( line );
      if strcmp( token, 'define' )
	 found_define = 1;
      end
   end

   if found_define
   
      % The rest of the line should be a string and a decimal digit.
      [ string, line ] = strtok( line );
      [ value ] = sscanf( line, '%d', 1 );

      % Look at the end of the string to find the variable to assign to.
      if strcmp( string( max(end-5,1) : end ), '_width' )
	 width = value;
	 name = string(1:end-6);
      elseif strcmp( string( max(end-6,1) : end ), '_height' )
	 height = value;
	 name = string(1:end-7);
      elseif strcmp( string( max(end-5,1) : end ), '_x_hot' )
	 x_hot = value;
	 name = string(1:end-6);
      elseif strcmp( string( max(end-5,1) : end ), '_y_hot' )
	 y_hot = value;
	 name = string(1:end-6);
      end

   end

end

fprintf( 'Image name:      %s\n', name   );
fprintf( 'Image width:     %d\n', width  );
fprintf( 'Image height:    %d\n', height );
fprintf( 'Image x hotspot: %d\n', x_hot  );
fprintf( 'Image y hotspot: %d\n', y_hot  );

pixels = height*width;          % Number of pixels in image.
nbytesw = ceil( width/8 );      % Bytes needed for each image row.
bytes_needed  = height*nbytesw; % Bytes needed for image data.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read past some words that may follow "static".
[ token, line ] = strtok( line );
while strcmp( token, 'const' ) | strcmp( token, 'unsigned' )
   [ token, line ] = strtok( line );
end
[ token, line ] = strtok( line, sprintf( ' \t[' ) );

% Find beginning of image data.
[ token, line ] = strtok( line, sprintf( '{' ) );
line = line(2:end);

data = zeros( nbytesw, height );
bytes_read = 0;
end_of_data = 0;

[ data, bytes_read ] = getdata( data, bytes_read, line, bytes_needed );

while ( bytes_read < bytes_needed ) & ~end_of_data
   line = getline( fid );
   [ data, bytes_read ] = getdata( data, bytes_read, line, bytes_needed );
end

if bytes_read < bytes_needed
   disp( 'Warning: End of file reached too early.' );
end

data = data';

X = zeros( height, width );             % Initialize output matrix.

for i = 1:nbytesw
   lb = 8*(i-1)+1;
   ub = min( 8*i, width );
   X(:,lb:ub) =  rem( floor( data(:,i)*pow2( 0: -1 : lb-ub ) ), 2 );
end

if isindexed                    % Indexed graymap.
   map = [ 0 0 0 ; 1 1 1 ];     % Create two-colour colour map.
   X = 2 - X;
else
   X = 1 - X;
end

function line = getline( fid )

line = fgetl( fid );
if ~ischar( line )
   fclose( fid );
   error( 'End of file reached too early.' );
end

function [ data, bytes_read ] = getdata( data, bytes_read, line, bytes_needed )

if ~isempty( line )
   line( line == ',' ) = ' ';
   bytes_missing = bytes_needed - bytes_read;
   [ x, bytes_read_now ] = sscanf( line, '%x', bytes_missing );
   lb = bytes_read + 1;
   bytes_read = bytes_read + bytes_read_now;
   ub = bytes_read;
   data(lb:ub) = x;
   if any( line == '}' )
	 end_of_data = 1;
   end
end
