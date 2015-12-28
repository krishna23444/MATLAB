function Y=stdmean(X,A)
%STDMEAN Weighted average based on error from the mean
%	stdmean(X,A)
%	This calculates a weighted mean based on how clusted the
%	data is. Each value is weighted inversely by the number
%	of standard deviations it is to the mean (Z).
%	A is the power to weight the Z by, for example:
%	if A = -1, then the values are weighted by Z^-1.
%	if A = -2, then the values are weighted by Z^-2.
%	A can be a fractional number.
%	Note : A is an optional parameter with default of -2
%
%	For vectors, STDMEAN(X)  is the mean value of the elements in X.
% 	For matrices, STDMEAN(X) is a row vector containing the mean value
% 	of each column.
%
%	Early tested have shown that using the stdmean does not
%	improve the performance, or reduce phase error .
if nargin < 2,
	A = -2;
end
if size(X,1) == 1,
	Z = (X - mean(X))./std(X);	%Find number of std each point
					%is away from mean.
	W = abs((Z+0.01).^(A));		%Calc the weighting factor of each point
	Y = sum(X.*W)./sum(W);
else
	for k = 1:size(X,2),
		Z(:,k) = (X(:,k) - mean(X(:,k)))./std(X(:,k));
					%Find number of std each point
					%is away from mean.
		W(:,k) = abs((Z(:,k)+0.01).^(A));
					%Calc the weighting factor of each point
		Y(:,k) = sum((X(:,k).*W(:,k)))./sum(W(:,k));
	end
end

