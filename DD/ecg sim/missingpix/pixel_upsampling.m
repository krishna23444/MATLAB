function full_size = pixel_upsampling(samples,m,n,indices)
% ******************************************************************
% Returns an m x n matrix whose entries take the values specified
%   by the vector 'samples' at the locations specified in 'indices',
%   and the value zero at all other locations
%
%   code by Jarvis Haupt and Robert Nowak, 2010
% ******************************************************************
%
% Inputs:
%    samples = sample values
%    indices = vector of locations of sample values
%    m = number of rows in output signal
%    n = number of columns in output signal
%    
%
% Output:
%    full_size = full-sized version of the sampled data
%
%

full_size = zeros(m,n);
full_size(indices) = samples;

end

