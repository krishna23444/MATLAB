function sub_samp = pixel_subsampling(orig,indices)
% *********************************************************************
% Returns samples of the input signal 'orig' at the locations
%   specified by the vector 'indices'
%
%   code by Jarvis Haupt and Robert Nowak, 2010
% *********************************************************************
%
% Inputs:
%    orig = vector or matrix to be subsampled
%    indices = vector of locations to sample
%
% Output:
%    sub_samp = vector of samples of the original signal at locations
%                  specified by 'indices'
%

[m,n]=size(orig);
orig_vec = reshape(orig,m*n,1);
sub_samp = orig_vec(indices);

end

