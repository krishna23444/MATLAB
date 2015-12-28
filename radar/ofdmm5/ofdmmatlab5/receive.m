function [Datarx, DiffPhRx] = receive(TimeSignal,ifftsize,carriers,...
		 wordsize,guardtype,guardtime,DataAvg,NoData,OutWordSize)
%RECEIVE Decodes a COFDM time waveform back into its data.
%	It decode the data from one data frame. This function requires
%	that the TimeSignal has the correct starting position.
%	function [Datarx, DataOut, DiffPh] = receive(TimeSignal,ifftsize,carriers,...
%		 wordsize,guardtype,guardtime,DataAvg,NoData)
%
%	INPUTS:
%	========
% 	TimeSignal : This is the input time signal for the COFDM waveform. The format
%		     of the output is a row vector.
%	ifftsize   : Size of ifft to use for generating the waveform
%	carriers   : Which carriers to use for the transmission
%	wordsize   : Number of bits to transmit on each carrier eg. 2 => QPSK
%	      	     1 => BPSK, 4 => 16PSK, 8 => 256PSK.
%	             Must be one of: 1,2,4 or 8
%	guardtype  : What type of guard period to use
%	             Options:
%	      	     0 = No Guard period
%	      	     1 = zero level guard period
%	      	     2 = cyclic extension of end of symbols
%	      	     3 = same as 2 but with the first half of the guard period = zero
%	guardtime  : Number of sample to use for the total guard time
%	DataAvg    : Data Averaging. Number of repeats sent of the same
%		     data word, so that it can be averaged at the receiver
%		     to help reduce the phase error.
%	NoData: is used for removing padding of the data. The padding is added
%		     by the transmitter on the last symbol if the number of data
%		     words doesn't fit into an integer number of symbols. NoData
%		     is the number of data words transmitted in the frame being
%		     decoded, e.g. if 10 bytes of data was sent and the DataOut
%		     format is byte format then NoData = 10.
%		     If padding hasn't been used set NoData to 0.
%	OutWordSize: This is the wordsize of the output data (DataOut). This will
%		     normally be set to 8, if the original data is in a byte format.
%		     However OutWordSize may be set to higher values (e.g. 16) if
%		     analog signal are being transmitted on the COFDM instead of
%		     digital data. The value of OutWordSize must match InWordSize
%		     on the transmitted. Note : OutWordSize is an optional
%		     parameter with a default of 8 bits.
%
%	OUTPUTS:
%	========
%	Datarx     : This is the output data that has been decoded from the 'TimeSignal'
%	      	     Its format is in words the same size as 'wordsize'. The output
%		     format of the data is a row vector.
%
%	DiffPhTx   : This is the actual phase difference between each symbol for the data
%		     This includes any noise or aborations due to the channel. It can be
%		     used for generating a histogram of the phase error. It has been adjusted
%		     so that the phase is centered around the phase locations of the data
%		     For Example for QPSK, the output phase is from -45 deg to 315 deg. This
%		     is for IQ locations at, 0, 90, 180, 270 deg.
%
%	Copyright (c) Eric Lawrey 1997
%
%	See:	TRANSMIT, WRFILE, CHANNEL

%	Modifications:
%	16/6/97	Started working on the function, it isn't finished yet.
%	17/6/97 Continued work on the receive function, it is now mostly finished
%		and has been partly tested.
%	18/6/97	Changed the way thay the DiffPhTx is generated, so that the phase out is based
%		on the phase locations. This was done so the phase error can be easily
%		calculated. Negative phase errors centered around the 0deg phasor are no
%		longer 359.6 deg for example but -0.4 deg. Fixed a bug due to having
%		guardtype = 0
%	3/8/97	Added data averaging allowing duplicate data to be sent to
%		reduce the error rate.
%	12/8/97	Updated to data averaging to the same method used by the transmitter
%		and added the ability to trim the data back to compensate for padding.
%		The padding doesn't work yet
%	13/8/97	The padding problem was fixed by rotating the transmitted data
%		which was incorrect, and clipping the DiffPhRx array to the
%		correct length.
%

% Required External Functions
%	subsamp.m

if nargin < 9,
	OutWordSize = 8;	%Set the default
end

%=========================================================================
%Strip back the number of samples to make it a multiple of the symbol size
%=========================================================================
if guardtype == 0,
	guardtime = 0;
end

SymbLen = length(TimeSignal)+guardtime;	%Find total number of samples
					%per symbol, including guard.
TimeSignal = TimeSignal(1:(SymbLen-rem(SymbLen,ifftsize+guardtime)));

					%Find the number of symbols in the input time waveform
numsymb = length(TimeSignal)/(ifftsize+guardtime);

%==========================================================================
%Reshape the linear time waveform into fft segments and remove guard period
%==========================================================================
if guardtype ~= 0,
	symbwaves = reshape(TimeSignal,ifftsize+guardtime,numsymb);
	symbwaves = symbwaves(guardtime+1:ifftsize+guardtime,:); %Strip off the guard period
else
	symbwaves = reshape(TimeSignal,ifftsize,numsymb);
end

fftspect = fft(symbwaves)';	%Find the spectrum of the symbols

DataCarriers = fftspect(:,carriers);	%Extract the used carriers from the symbol spectrum.
clear fftspect;				%Save some memory

CarrPh = angle(DataCarriers);		%Find the phase angle of the data
NegCarrPh = find(CarrPh<0);		%Map the phase angle to 0 - 2pi radians
CarrPh(NegCarrPh) = rem(CarrPh(NegCarrPh)+2*pi,2*pi);

clear NegCarrPh;
%================================
%Apply DQPSK on the received data
%================================
DiffPh = diff(CarrPh);		 	%Compare phase of current to previous symbol

DiffPh = DiffPh*360/(2*pi);		%convert from radians to degrees

NegPh=find(DiffPh<0);			%Make all phases between 0 - 360 degrees
DiffPh(NegPh)=DiffPh(NegPh)+360;

DiffPh = reshape(DiffPh',1,size(DiffPh,1)*size(DiffPh,2)); %Convert back to a serial stream
DiffPh = subsamp(DiffPh,DataAvg,1,0);	%Average the phase for duplicate words
NegPh=find(DiffPh<0);			%Make all phases between 0 - 360 degrees
DiffPh(NegPh)=DiffPh(NegPh)+360;

%DiffPh = reshape(DiffPh,size(DiffPh,1)*DataAvg,size(DiffPh,2)/DataAvg);
Datarx = zeros(size(DiffPh));
PhInc = 360/(2^wordsize);		%Find the increment between the phase locations
DiffPhRx = rem(DiffPh/(PhInc)+0.5,(2^wordsize))*(PhInc)-(PhInc/2);

Datarx = floor(rem(DiffPh/(360/(2^wordsize))+0.5,(2^wordsize)));

if NoData == 0,
	%Stip back the length of Datarx so it is a multiple of the
	%OutWordSize/wordsize.
	Datarx = Datarx(1:floor(length(Datarx)/(OutWordSize/wordsize))*(OutWordSize/wordsize));
else
	if (NoData*(OutWordSize/wordsize) > length(Datarx)),
		disp('WARNING : Received Data Shorter than expected');
		disp(['Expected = ', num2str(NoData*(OutWordSize/wordsize))]);
		disp(['Received = ', num2str(length(Datarx))]);
		
	else
		Datarx = Datarx(1:NoData*(OutWordSize/wordsize));
		DiffPhRx = DiffPhRx(1:NoData*(OutWordSize/wordsize));
	end
end
