function I = getimages(filename)
% getimages Get attacked image names from file.
% getimages(filename) reads all image names in the text data 
% file 'filename'. In return we get a matrix with the image
% names (these are not repeated and are in alèhabetical order).
% The path where the data file searched is given by the global DATA_INPUT_PATH.
%
% Written by Vladimir Calderon
%
% Copyright (c) 2001, Shelby Pereira, University of Geneva
% 
%  Permission to use, copy, modify, and distribute this software and its
%  documentation for any non-commercial purpose and without fee is hereby
%  granted (GPL), provided that the above copyright notice appear in all
%  copies and that both that copyright notice and this permission notice
% appear in supporting documentation. This software is provided "as is" 
% without express or implied warranty. The authors shall not be held
% liable in any event for incidental or consequential damages in
% connection with, or arising out of, the furnishing, performance, or
% use of this program.
% 
% If you use the Checkmark software package for your research, please cite:
%
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madueño, Stéphane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001.
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
% Sviatoslav Voloshynovskiy, Shelby Pereira, Victor Iquise and Thierry Pun, 
% Attack modelling: Towards a second generation benchmark, Signal Processing, 
% Special Issue: Information Theoretic Issues in Digital Watermarking, 2001. V. Cappellini,
%  M. Barni, F. Bartolini, Eds. (to appear) 
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
global HTML_OUTPUT_PATH
global INCLUDE_HEADER_PATH


[ I ] = textread(filename,'%s%*[^\n]');

I = unique(I);
