%IMAGETX This script produces a wav file of a COFDM frame suitable for
%	a playing as a COFDM signal generator.
%	It generates a signal which consists of a number of frames, each
%	separated by a frame guard time of one symbol period. The signal is
%	zero during this period.
%
%	This transmission uses a simple synchronisation method. A null
%	symbol (no signal) is added as a synchronisation symbol at the
%	start of each frame. An envelop detector, in combination with a 
%	moving average of the envelop is used to find this null symbol.
%	The transistion from the null symbol to the first OFDM symbol in
%	the frame (i.e the phase reference) is used to synchronise the
%	receiver. No additional fine tunning is performed.
%
%	A pre and post signal is added to the OFDM signal, to allow synchronisation
%	of the first frame. The post signal is to allow for tolerances in the
%	total number of samples. The pre signal is just a set of tones, not an OFDM signal.
%	I guess I was too lasy to do any thing more complicatied.
%
%	No link layer has been added to the transmission. Data is simply padded
%	with zeros, so that the number of data words requires an integral number of
%	OFDM symbols. The number of data words sent is extracted from the original
%	data at the receiver using rddatatx.m. The original data is loaded at the
%	receiver so that it can be compared with the received data. This allows
%	the Bit Error Rate (BER) and phase error to be calculated. The original data
%	loaded at the receiver also allow the number of transmitted data words to be found.
%	
%
%	Copyright (c) July 1997 Eric Lawrey

%================
%	Modified:
%	29/7/97	11:00am	cofdmwav.m
%	Modified simtxrx.m so that it would just generate the output of the
%	COFDM transmitter, and store the result in a wav file.
%
%	29/7/97	11:30am cofdmwav.m
%	Changed it so that a wav file of multiple frames could be generated.
%	31/7/97	8:44am	rdimage.m
%	Modified cofdmwav.m so that it now uses a bmp file as it data source
%
%	3/8/97	2:00pm imagetx.m
%	Added the option of compressing the contrast of the picture
%	to help prevent roll over of intensity when sending 8bits/word.
%	Also added data averaging, allowing duplicates of data to
%	be sent and recombined to reduce the phase error. This works,
%	except for it giving errors for black pixels.
%
%	12/8/97	10:30pm imagetx.m
%	Made many major changes to the software so that multiple data
%	types can be transmitted. Including random data, pictures, and
%	general binary files. Also a common setting script is now used
%	for both the transmitter and receiver. This is settings.m.
%
%	17/8/97 2:00 pm imagetx.m
%	Moved the calculation of the carriers to use into the settings
%	script.

%======================================================
%	External functions required to run this script:
%	settings.m
%	rddatatx.m
%	channel.m
%	wavwr.m		(from the Matlab web site)
%	transmit.m
%	rdimage.m
%	rddatatx.m		(Script to read in the data to transmit)

clear all;
flops(0);
tic;			%Measure the time it takes to run the simulation
settings		%Initialize all the setting required

rddatatx	%read in the data to transmit. This could be random data, an image
		%or a general binary file.


FrameSig = zeros(1,FrameGuard);		%Generate the blank period between frames
TimeSignal = [];
if SymbPerFrame ~= 0,
	%====================================
	%Generate a set of tones for the pre and post signals
	f = 0.25;	%Frequency 0.5 = nyquist rate
	N = (ifftsize+guardtime)*8;
	Header = sin(0:f*2*pi:f*2*pi*(N-1));
	f = 0.117;
	Header = Header + sin(0:f*2*pi:f*2*pi*(N-1));
	%====================================

	TimeSignal = [];
	NumCarr = length(carriers);
	NoDataWords = length(Datatx)*DataAvg;
	numbsymb = ceil(NoDataWords/NumCarr);

	%Check if the number of symbols required will require multiple frames
	if numbsymb > SymbPerFrame,
		%=========================
		%Multiple Frames		
		%=========================
		Dataleft = Datatx;
		while length(Dataleft) > 1,

			AmountData = min(SymbPerFrame*NumCarr/...
				DataAvg,length(Dataleft));
			FrameData = Dataleft(1:AmountData);
			Dataleft = Dataleft(AmountData+1:length(Dataleft));
			%===========================================================
			%Generate one frame of the COFDM signal from data to be sent
			%===========================================================
			BaseSignal = transmit(FrameData,ifftsize,carriers,...
 		 		wordsize,guardtype,guardtime,windowtype,DataAvg);
			TimeSignal = [TimeSignal FrameSig BaseSignal];
		end
		SigPow = std(BaseSignal); %calc the signal power of the OFDM signal 
					  % so the the header power can be scaled to match
		TimeSignal = [SigPow*Header TimeSignal FrameSig SigPow*Header];
	else	
		%=========================
		%Single Frame
		%=========================
		BaseSignal = transmit(Datatx,ifftsize,carriers,...
	 		wordsize,guardtype,guardtime,windowtype,DataAvg);
		SigPow = std(BaseSignal);
		Header = SigPow*Header;
		TimeSignal = [Header FrameSig BaseSignal FrameSig Header];
	end
else
	%=========================================
	%Single Frame but generated multiple times
	%=========================================
	%If SymbPerFrame == 0 and NoFrames is greater than 1 then
	%the frame generated from the data is copied multiple times
	BaseSignal = transmit(Datatx,ifftsize,carriers,...
	 		wordsize,guardtype,guardtime,windowtype,DataAvg);
	%Concatenate all the frames together
	for k = 1:NoFrames,
		TimeSignal = [TimeSignal BaseSignal FrameSig];
	end
end
%Generate a very simple multipath model (i.e 2 tap filter)
%Multi can be set to any impluse function for more complicated
%multipath modelling
Multi = zeros(Delay,1);
Multi(1) = 1;
Multi(Delay) = MultiMag;

%Apply a simulated channel model to the data
%See channel for more detail
TimeSignal = channel(TimeSignal, Comp, SNR, Multi);


%=================
%Scale the signal
%=================
MaxSig = max(abs(TimeSignal(N:length(TimeSignal)-N))); %Find the max of the OFDM signal
						  %removing the header and trailer before
						  %finding the maximum
RMSSig = std(TimeSignal(N:length(TimeSignal)-N));
if (FullScaleFlag==1)
	TimeSignal = TimeSignal*FullScale/MaxSig;
	RMSSig = RMSSig/MaxSig*FullScale;
	MaxSig = FullScale;
else
	TimeSignal = TimeSignal*sqrt(TxSignalPow)/RMSSig;
	ind = find(abs(TimeSignal)>0.9999);		%Clip the signal to -1 to +1
	TimeSignal(ind) = ones(size(ind)).*sign(TimeSignal(ind))*0.9999;
	%Recalculate the Maximum and the RMS signal
	MaxSig = max(abs(TimeSignal(N:length(TimeSignal)-N))); 
	RMSSig = std(TimeSignal(N:length(TimeSignal)-N));
end
%==============================
%Save the signal as a .WAV file
%==============================
wavwrite(TimeSignal,Fs,res,txwavfile);

%======================
% Display some results
%======================
disp(['Max Signal Level: ' num2str(MaxSig)]);
disp(['RMS Signal Level: ' num2str(RMSSig)]);
disp(['Peak to RMS power ratio : ' num2str(20*log10(MaxSig/RMSSig)) 'dB']);
disp(['Total Time: ' num2str(toc) 'sec']);
disp(['Total FLOPS: ' num2str(flops)]);
disp(['Process Speed : ' num2str(flops/toc) ' flops/sec']);


