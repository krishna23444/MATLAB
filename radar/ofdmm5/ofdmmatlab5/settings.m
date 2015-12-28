%SETTINGS Contains the settings to use for the COFDM transmission
%	This is a common file used for the transmission and reception
%	It specifies all the link properties, channel properties,
%	data to send and filenames for input an output files
%
%	NOTE: Not all setting combinations work as only a few have been
%	fully debugged. If the receiver is giving very high error rates, 
%	then it is likely that there is a synchronisation error. If a
%	different ifft_size, NumCarr and guardtime is used this may fix the
%	error. For example: ifftsize = 2048, NumCarr = 800 guardtime = 512
%	didn't sync propoerly for the Corrs.wav data set, but changing it
%	to ifftsize = 1024, NumCarr = 400 and guardtime = 256, works.
%	Also NumCarr must be < ifftsize/2 as the generated waveform
%	is real and not complex.
%
%	Due to processing and memory limitations, the maximum size input
%	data is approx. 20-100kB depending on the modulation scheme.
%
%	This code is not likely to work using the student version of Matlab 4.2
%	due to the array size limitation of the student version.
%
%	There may be some capability problems when running this code in Matlab 5.
%	I think the main problem is with the scripts used to read and write the
%	wave files. These could be changed to the in-built Matlab 5 wave scripts.
%
%	Written by Eric Lawrey 12/8/97
%
%	15/4/1999
%	Added signal scaling TxSignalPow and FullScaleFlag.

%================
% COMMON SETTINGS
%================
wordsize = 8;		%Number of bits per carrier per symbol to send
			%Allowable values are 1,2,4,8. 1 = BPSK, 2=QPSK, 4=16PSK, 8=256PSK
OutWordSize = 8;	%Base wordsize of input data to the COFDM transmission,
			%typically 8 bit. The input and output data is converted from
			%the OutWordSize to wordsize during the transmission
ifftsize = 1024;	%size fourier transform to generate signal (it is equal to the
			%number of samples in the symbol.) Note : must be > 2* NumCarr
NumCarr = 400;		%Number of transmission carriers
CarrSpacing = 1;	%Spacing between carriers. (1 = use all fft bins,
			%2 = every second bin)
guardtime = 256;	%Total guard time in samples.
			%(This is typically 25% of the FFT size)
guardtype = 2;		%1 = Zeroed signal, 2 = cyclic extension, 3 = half zero, half cyclic
			%Note: Only type 3 has been tested fully
windowtype = 0;		%0 = No window, 1 = Hanning window of symbol.
			%The window is applied to the base band time waveform.

FrameGuard = ifftsize+guardtime;  %Guard Time between successive frames (1 symbol)

PictureComp = 1;	%Fraction of picture amplitude to compress
			%by to over come, wrap around from black to white
			%due to a phase error (set to 1 for no compression)
DataAvg	= 1;		%Data Averaging, dupticate transmission of
			%data words to reduce the phase error. (Normally set to 1)
SymbPerFrame = 30;	%Number of data symbols per frame. The timing is resynchronized
			%at the start of each frame. Set to 0 if only
			%want all the data to be transmitted with one frame.

%=====================
% TRANSMITTER SETTINGS
%=====================
NoFrames = 3;		%Number of duplicate data frames to generate Only valid
			%if SymbPerFrame = 0
FullScaleFlag = 1;	%Flag to indicate if the OFDM signal show be scaled to
			%full scale of the output WAV file. i.e giving maximum
			%signal power with no clipping. The signal is scaled
			%to FullScale.
			%FullScaleFlag = 1, scale output sigal to full scale, TxSignalPow 
			%is not used
			%FullScaleFlag = 0, scale output signal based on TxSignalPow.
FullScale = 0.95;	%Fraction of wav file full scale must be less that 1
TxSignalPow = 0.1;	%Scaling of the transmitter signal power
			%TxSignalPow is the fraction of max signal for the wave file
			%that the RMS of the OFDM signal will be scaled to.
			%i.e. 0.01 => RMS OFDM power is 20dB below maximum signal
			%power for the WAV format.
			%if TxSignalPowis set above about 0.05 some clipping may start
			%to occur.

%==================
% RECEIVER SETTINGS
%==================
quickrate = round(FrameGuard/128)+1;
			%Amount of subsampling to find the approx starting position of the
			%start frame. The larger quickrate is the faster the search is but
			%the lower the probability of finding the correct starting location.
			%quickrate needs to be lower as the SNR worsens. Typical values
			%are from 10 - 200

%=================
% CHANNEL SETTINGS
%=================
Comp = 0;		%Peak Power Compression (in dB relative to peak signal power)
			%set to zero for no signal compression or clipping
SNR = 300;		%Signal to noise ratio of received signal in dB, setting > 300
			%adds no noise.
Delay = 1;		%Delay of single reflection multipath signal in samples
			%Set to 1 for no multipath.
MultiMag = 1;		%Magnitude of the reflection with respect to the direct signal
			%e.g. Setting to 0.5 makes the reflection half the amplitude of the
			%direct signal

%====================
% INFORMATION FORMATS
%====================
DataType =4;		%Type of data to send in the transmission
			% 1 = random data (Amount set by NoRandData)
			% 2 = grey scale bitmap image (only the picture data is sent
			% not the file header or colour map) This is useful for high
			% error rate conditions
			% 3 = general binary data file. This allows for any data file to be
			% sent, e.g. a recorded wavefile, a gif image, a jpg image, an excel
			% document etc. The file is sent simply as a binary file with no
			% knowledge of the file structure. Thus an error in the file header
			% could corrupt the entire file. In a practical system the forward
			% error correction would be required to reduce the error to
			% an acceptable level to send general data.
			% To make the data link easier to implement the number of data words
			% sent and the number of frames used is not transmitted, but sent via
			% a file.
			% 4 = Wave Sound file. This reads in an 8bit windows 3.1 wav file
NoRandData =12000;	%Number of random data words to transmit if the DataType = 1.
RandSeed = 1234;	%Random Seed used for generating the random data sent. Both the
			%transmitter and receiver needs to know the seed. Only valid if
			%DataType = 1.
Fs = 44100;		%Sample rate of COFDM wav file generated
res = 16;		%No. bits/sample of saved wavefile
txwavfile = 'imagetx.wav';	%Filename of the wavefile generated
rxwavfile = 'imagetx.wav';	%Filename of the wavefile to decode
switch DataType
case 2
	infile    = 'fish.bmp';	%input filename of the bmp file or general file to transmit
	outfile   = 'out.bmp';		%Filename to store the received image
case 3
	infile    = 'DC-x.jpg';	%input filename of the bmp file or general file to transmit
	outfile   = 'out.jpg';		%Filename to store the received image
case 4
	infile    = 'corrs11.wav';	%input filename of the bmp file or general file to transmit
	outfile   = 'out.wav';		%Filename to store the received image
otherwise
	infile    = 'fish.bmp';	%input filename of the bmp file or general file to transmit
	outfile   = 'out.bmp';		%Filename to store the received image
end


errorfile = 'errorpic.bmp';	%Filename of the picture of the
				%errors induced in the received image.
				%Only valid for DataType = 2;
fileknown = 1;		%Indicates whether the OFDM signal file being read is known
				%i.e. whether transmitted data file exists so that the 
				%exact data size can be found.
				%if fileknown = 0, the OFDM signal is read straight from
				%the file given with no regard for transmitted data file.
				%Error analysis can not be done on files read in this way
				%as there is nothing to check the received data against.
				%Also padding may be added to the received data.
				%fileknown = 1, is the normal operation where the original
				%received data is checked against the transmitted data.

%==================================================
%Calc Carriers used for a single wide COFDM channel
%==================================================
%This section calculates the carriers used to transmit the signal.
%carriers is a vector of the carriers used in the transmission, e.g. [3,5,7,8,9]
%Modifying carrier, allows the spectrum to be tailored to the requirements of the channel
MidFreq = ifftsize/4;			%find the middle of the spectrum
StartCarr = MidFreq - round(((NumCarr-1)*CarrSpacing/2));
FinCarr = MidFreq + floor(((NumCarr-1)*CarrSpacing/2));
carriers = [StartCarr:CarrSpacing:FinCarr ]+1;

%carriers = [2:NumCarr];
NumCarr = length(carriers);
