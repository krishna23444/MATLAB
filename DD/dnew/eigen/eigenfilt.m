function [h] = eigenfilt(N,F,M2,W)
%eigenfilt	Filter Design using the Eigenfilter Method.
%		h = eigenfilt(N,F,M2,W)
%		Gives the impulse response of the Nth order filter that
%		minimizes weighted passband and stopband errors
%		by using the Eigenfilter method.
%		Frequency response is specified by F and M2.
%	        Vectors F and M2 specify the frequency and magnitude
%	        breakpoints for the filter such that PLOT(F,M2) would show a
%	        plot of the desired frequency response. The elements of M2 must
%	        appear in equal-valued pairs.  The frequencies in F must be
%	        between 0.0 < F < 1.0, with 1.0 corresponding to half the
%	        sample rate. They must be in increasing order, start with 0.0,
%	        and end with 1.0.
%		M2 must have elemens 1 or 0 with 1's and zeros in blocks of
%		2.  i.e M2 = [0 0 1 1 0 0 1 1 0 0]
%	        W is used to specify weighting in each
%	        of the pass or stop bands corresponding to vectors F and M2,
%		and has half the number of elements of F and M2.
%		The sum of the elements in W must add up to 1.

M = (N-1)/2;
P = [];			%Initialize P

%%%	Make elements of P

flag=0;
for i=1:M+1
	for j=1:M+1
		P(i,j)=0.0;
		for k=1:2:length(F)-1
		 if (M2(k) == 0)
	          P(i,j) = P(i,j)+(W((k+1)/2)/pi)*Pstop(i-1,j-1,F(k),F(k+1));
		 elseif (M2(k) == 1)
		  if (F(k) == 0)
		   P(i,j) = P(i,j)+(W((k+1)/2)/pi)*Ppass(i-1,j-1,F(k),F(k+1)...
				,0);
		  elseif (F(k+1) == 1)
		   P(i,j) = P(i,j)+(W((k+1)/2)/pi)*Ppass(i-1,j-1,F(k),F(k+1)...
				,1);
		  else
		   if flag==0
		   temp1=F(k);
		   temp2=F(k+1);
		   flag=1;
		   end
		   P(i,j) = P(i,j)+(W((k+1)/2)/pi)*Ppass(i-1,j-1,F(k),F(k+1)...
				,(temp1+temp2)/2);
		  end
		 end
		end
	end
end

[U,S,V] = svd(P);
b = U(:,M+1);
h = [];
for i=1:M		%find h(n) from b(n)
	h(i) = 0.5*b(M+1-(i-1));
end
h(M+1)=b(1);
for i=2:M+1
	h((M+1)+(i-1)) = 0.5*b(i);
end









