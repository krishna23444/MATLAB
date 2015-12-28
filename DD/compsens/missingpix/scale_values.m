function scaled_out = scale_values(input_sig,minn,maxx)
% ***********************************************************************
% Affine rescaling of the values in input_sig to the range [minn,maxx]
%
%   code by Jarvis Haupt and Robert Nowak, 2010
% ***********************************************************************
%
% Inputs:
%    input_sig = vector or matrix to be rescaled
%    minn = desired minimum value for rescaled output
%    maxx = desired maximum value for rescaled output
%
% Output:
%    scaled = rescaled version of input vector or matrix
%

% Determine dimension of input signal
dim = length(find(size(input_sig) > 1));

% Compute desired output dynamic range
sig_range = maxx-minn;

% Fix minimum value of input signal to zero
in_min = min(input_sig);
for i=1:dim-1
    in_min = min(in_min);
end
input_sig = input_sig - in_min;

% Fix maximum value input signal to one
in_max = max(input_sig);
for i=1:dim-1
    in_max = max(in_max);
end
scaled_sig = input_sig./in_max;


% Scale the range of the resulting scaled signal to desired dynamic range
scaled_sig = sig_range * scaled_sig;

% Add the offset value 'minn'
scaled_out = scaled_sig + minn;

end