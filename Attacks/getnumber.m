function n = getnumber(a_string, A)
% getnumber Return index of matching string in A
% getnumber(a_string,A) Looks for a_string in A (cell), if it succeeds, it returns
% the index number, else, it returns 0. If a_string is a cell array of strings
% the function returns an array with the numbers.
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
if (iscellstr(A) ~= 1)
    error('A must be a cell array of strings');
end
if (iscellstr(a_string) ~= 1)
    a_string = {a_string};
end
p = size(a_string,1);
m = size(A,1);
n = zeros(p,1);
for j=1:p
   for i=1:m
       if(strcmp(a_string(j),A(i)))
           n(j) = i;
           break;
       end
   end
end
