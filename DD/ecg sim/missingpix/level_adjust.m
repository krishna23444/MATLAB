function adjusted = level_adjust(orig,frac)
% **********************************************************************
% Rescales input signal to saturate fixed fraction of 
%   upper and lower extreme amplitude values
%
%   code by Jarvis Haupt and Robert Nowak, 2010
% **********************************************************************
%
% Inputs:
%    orig = vector or matrix to be scaled/saturated
%    frac = fraction of amplitude values to saturate
%           (eg, frac=0.01 saturates smallest and largest 1% of values)
%
% Output:
%    adjusted = rescaled/saturated version of original input
%

% Reshape input into vector
[m,n]=size(orig);
temp_vec = reshape(orig,m*n,1);

% Set number of histogram bins
bins = round(sqrt(m*n)/4);

% Obtain histogram of amplitude values
[counts,amps] = hist(temp_vec,bins);

% Compute cumulative sum of histogram values
CS = cumsum(counts);

% Identify cutoff indices to saturate extreme values 
delta = frac*CS(end);
CS_offset = CS - delta;
f = find(CS_offset > 0);
inx_low = f(1);
%
delta = (1-frac)*CS(end);
CS_offset = CS - delta;
f = find(CS_offset > 0);
inx_high = f(1);

% Obtain intensity values corresponding to cutoff indices
val_low = amps(inx_low);
val_high = amps(inx_high);

% Rescale/saturate image to the new intensity values
adjusted = orig - val_low;
adjusted = adjusted./(val_high-val_low);

end

