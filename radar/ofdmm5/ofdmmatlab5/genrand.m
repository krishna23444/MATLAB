function Datatx = genrand(NumSymb,wordsize,NumCarr,seed)
%GENRAND Generates random data to transmit
%	 Datatx = genrand(NumSymb,wordsize,NumCarr)
%
%	 Datatx = genrand(NumSymb,wordsize,NumCarr,seed)
%	 If a seed is given the the random data will always
%	 be the same when the same seed is given.
%	 Note : the previous random seed is unaffected.

if nargin == 4,
	prevseed = rand('seed');	%Save the old random seed
	rand('seed',seed);		%Set to new seed
	Datatx = floor(rand(NumSymb,NumCarr)*(2^wordsize)); %Generate the data
	rand('seed',prevseed);		%Restore the old seed
else
	Datatx = floor(rand(NumSymb,NumCarr)*(2^wordsize)); %Generate the data
end
	