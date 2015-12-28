function Y=zerohold(X,N)
%ZEROHOLD Oversample the input X, by N times, using zero order hold.
%	  Y=zerohold(X,N)
%	  If X is a matrix then each row is over sampled
%
%	  See : SUBSAMP
%	  Copyright (c) Eric Lawrey July 1997

%Modifications:
%	10/7/97	Started writing the function. This function is finished
%		and tested. It appears to work.
%	3/8/97	Changed back to the older algorithum of doing zero hold
%		by copy one column at a time. This was because the other
%		algorithum doesn't work for multiple rows of data.
if N > 0,
	if N > 1,
		N = round(N);
		Y = zeros(size(X,1),size(X,2)*N);	%initialize Y

		for k = 1:size(X,2)*N
			Y(:,k) = X(:,ceil(k/N));	%Copy multiple X values into Y
		end
%		for k = 1:N:size(X,2)*N,	%Copy multiple X values into Y
%			Y(:,k:k+N-1)=X(:,ceil(k/N)).*ones(size(X,1),N);
%		end
	else
		Y=X;
	end
end