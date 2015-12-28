function Y=subsamp(X,N,ph,avg)
%SUBSAMP Subsamples the input X by an amount N, using averaging
%	 Y=subsamp(X,N)
%	 The samples are subsampled as rows. Thus if X is a matrix
%	 each row is subsampled.
%	 If the length of X is not a multiple of N samples then remaining
%	 samples are ignored.
%
%	 Y=subsamp(X,N,ph)
%	 ph = 0 : This takes the standard averaging of the data when
%	 	  subsampling the signal.
%	 ph = 1 : This averages data assuming that it is phase data. This
%	 	  compensates for phase wrap around.
%
%	 Y=subsamp(X,N,ph,avg)
%	 avg = 0 : This uses standard averaging to calculate the mean data.
%	 avg = 1 : This uses the stdmean function to do a weighted average
%		   instead.
%	 See : ZEROHOLD, STDMEAN
%
%	 Copyright (c) July 1997 Eric Lawrey

%Modified:
%	10/7/97	Started function. This function is finished and tested.
%	6/8/97	Added the option to use the stdmean function instead of the
%		standard averaging. Early tests have shown that it does
%		not improve the performance of the COFDM system.

%	External Functions:
%	stdmean.m

	X=X(:,1:floor(size(X,2)/N)*N);
if (size(X,2) > 1)&(N>1),

	if nargin < 4,
		avg = 0;	%If avg not given set the default
	elseif nargin < 3,
		ph = 0;		%Set to the default if no given
		avg = 0;	%i.e use standard averaging using the mean
	end
	if ph == 0,
		Y = zeros(size(X,1),size(X,2)/N);
		for k = 1:size(X,1),
			if avg ==0,
				Y(k,:)=mean(reshape(X(k,:),N,size(X,2)/N));
			else
				Y(k,:)=stdmean(reshape(X(k,:),N,size(X,2)/N));
			end
		end
	else
		Y = zeros(size(X,1),size(X,2)/N);
		for k = 1:size(X,1),
%		Y(k,:)=mean(reshape(X(k,:),N,size(X,2)/N));
			ang = (reshape(X(k,:),N,size(X,2)/N)*2*pi/360).';
			mag = ones(size(ang));
			[x,y] = pol2cart(ang,mag);
			if avg == 0,
				AvX = mean(x')';
				AvY = mean(y')';
			else
				AvX = stdmean(x',(-2))';
				AvY = stdmean(y',(-2))';
			end
			[ang,mag] = cart2pol(AvX,AvY);
			Y(k,:) = (ang.') * 360/(2*pi);
		end
	end

else
		Y=X;
end
