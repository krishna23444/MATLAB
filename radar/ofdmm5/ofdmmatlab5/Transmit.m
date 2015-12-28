function BaseSignal = transmit(Datatx,ifftsize,carriers,...
		      wordsize,guardtype,guardtime,windowtype,DataAvg)
%TRANSMIT Generates a COFDM waveform from an input data.
%	  function BaseSignal = transmit(DataIn,ifftsize,carriers,...
%		    wordsize,guardtype,guardtime,windowtype,DataAvg)
%
%	  This function generates a COFDM time waveform based on the input parameters
%	  and the data given. The data is transmformed into a single frame COFDM signal. 
%	  This for the simulation of a COFDM phone system.
%	  INPUTS:
%	  ========
%	  Datatx     : Data to transmit in the wordsize given. eg. for wordsize = 2
%		       Data is from 0-3, for wordsize = 8, data is from 0-255
%		       The data should be a single row vector. See convbase.m to
%		       convert from 8bit data to the required wordsize.
%		       e.g. datatx = convbase(datain, 8, wordsize);
%	  ifftsize   : Size of ifft to use for generating the waveform
%	  carriers   : Which carriers to use for the transmission
%	  wordsize   : Number of bits to transmit on each carrier eg. 2 => QPSK
%		       1 => BPSK, 4 => 16PSK, 8 => 256PSK.
%		       Must be one of: 1,2,4 or 8
%	  guardtype  : What type of guard period to use
%		       Options:
%		       0 = No Guard period
%		       1 = zero level guard period
%		       2 = cyclic extension of end of symbols
%		       3 = same as 2 but with the first half of the guard period = zero
%	  guardtime  : Number of sample to use for the total guard time
%	  windowtype : Type of window to apply to the time waveform of the symbol
%		       Options: 
%		       0 = No windowing
%		       1 = Hamming window
%	  DataAvg    : Data Averaging. Number of repeats to send of each data word, so
%		       that the repeats can be combined at the receiver to reduce the 
%		       phase error, and thus to BER. DataAvg = 1 (No duplication)
%			
%	  OUTPUTS:
%	  ========
%	  BaseSignal : This is the output time signal for the COFDM waveform. The format
%		       of the output is a row vector.
%	  Datatx     : Data transmitted. This is the input data (DataIn) converted to 
%		       the number base used for transmission, based on wordsize.
%	  
%	  Copyright (c) Eric Lawrey 1997
%
%	  See:	RECEIVE, RDFILE.

%===============================
%	External Functions Used :
%	None

%===============================
%	Modifications:
%	8/6/97	Redo of the previous simulation script. (based on distort.m)
%	15/6/97	Continuing work on this function, currently not finished
%	16/6/97 Continued work on function, it is now finished and works, but not all 
%		the features have been tested.
%		I have tested the windowing and the zeroed guard period. The code has also
%		been optimized a bit and runs ~10 times faster then it used to, plus
%		it can handle much bigger files (tested upto 87kbytes, wordsize=4), in 35sec
%		It appears to work as a function.
%		The function needs to be changed so that it does not read the file directly
%		but instead get the data as input.
%	17/6/97	Modified the function so that it does read the input file from within 
%		the transmit function. This is so that the file can be read else where
%		then split up into smaller frames, then processed by transmit.
%		Fixed up some logical errors in the program, and removed the output phase
%		variable as it can be easily calculated from the data being transmitted.
%	12/8/97	Changed the input requirements for Datatx. It is now DataIn which is a 
%		serial vector of byte data. The base conversion, reshaping of the data
%		into symbols, and padding of the input data is done by transmit.m. I also
%		data averaging that send duplicates of the data words. The duplicates are
%		sent as the very next data word. (No the best spreading, but easy to do).

%====================
% Initialization
%====================

%rand('seed',3567);
NumCarr = length(carriers);	%find the number of carriers


%=====================
% Apply Data Averaging
%=====================
%Duplicate data to be transmitted, duplicate each dataword having the next carrier
%also transmitting the same data word. This will not give the best diversity
%performance but is the easiest to implement.
DataOut = zerohold(Datatx,DataAvg);

%=============
% Pad the Data
%=============
%Format the input serial data stream into symbols
%Reshape the data to fit the number of carriers
numsymb = ceil(length(DataOut)/NumCarr);

%If the data length is not a multiple of the number of carrier the pad the data
%with zeros
if length(DataOut)/NumCarr ~= numsymb,
	DataPad = zeros(1,numsymb*NumCarr);
	DataPad(1:length(DataOut)) = DataOut;
	DataOut = DataPad;
end

clear DataPad;

%==============================
% Reshape the data into symbols
%==============================
DataOut = reshape(DataOut,NumCarr,numsymb)';	%Reshape the data into symbols

numsymb = size(DataOut,1)+1;	%find the total number of symbols 
				%including the phase reference symbol
%========================================
% Convert to DQPSK & add phase reference
%========================================
PhaseRef = round(rand(1,NumCarr)*(2^wordsize)+0.5);	%generate random phase ref.
DPSKdata = zeros(size(DataOut,1)+1,size(DataOut,2));
DPSKdata(1,:) = PhaseRef;
for k = 1:numsymb-1
	DPSKdata(k+1,:)=rem((DataOut(k,:) + DPSKdata(k,:)-1),(2^wordsize))+1;
end
%clear DataOut;

%=====================================
%Find the required spectrums
%=====================================
[X,Y] = pol2cart(DPSKdata*(2*pi/(2^wordsize)),ones(size(DPSKdata)));
CarrCmplx = X+i*Y;

NegCarriers = ifftsize-carriers+2;	%find the bins for the negative frequency carriers
TxSpectrums = zeros(numsymb,ifftsize);

for k = 1:numsymb
	%Place the carriers used into the full spectrum
	TxSpectrums(k,carriers) = CarrCmplx(k,:);
	TxSpectrums(k,NegCarriers) = conj(CarrCmplx(k,:));
end
clear NegCarriers;
%==================================
%Find the time waveform using IFFT
%==================================
BaseSignal = real(ifft(TxSpectrums'));

clear TxSpectrums;	%Save Memory

%=================================
%Window the signal
%=================================
if windowtype==1
	window = hamming(ifftsize);		%make window
	window2 = zeros(ifftsize,numsymb);
	for k = 1:numsymb-1
		window2(:,k) = window;
	end
	
	BaseSignal = window2.*BaseSignal;	%window the waveform
	clear window2;				%save memory	
	clear window;
end

%=================================
%Add a Guard Period
%=================================
if guardtype~=0
	if guardtype == 1 			%if guard period is just a zero transmission
		BaseSignal=[zeros(guardtime,numsymb);BaseSignal];
	elseif guardtype == 2
		EndSignal = size(BaseSignal,1);	%Find the number of columns in the BaseSignal
		BaseSignal=[BaseSignal((EndSignal-guardtime+1):EndSignal,:); BaseSignal];
	elseif guardtype == 3
		EndSignal = size(BaseSignal,1);	%Find the number of columns in the BaseSignal
		BaseSignal=[zeros(guardtime/2,numsymb); ...
			BaseSignal((EndSignal-guardtime/2+1):EndSignal,:); BaseSignal];
	end	
end

BaseSignal = reshape(BaseSignal,1,size(BaseSignal,1)*size(BaseSignal,2));
