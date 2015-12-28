%COFDMRD This script reads a COFDM waveform from a .WAV file and decodes it.
%	This script is the complement to the COFDMWAV script.
%	This script read the WAV file given the extracts the first frame
%	in the file. This frame is decoded and compared with the known data
%	sent by the COFDMWAV script.
%
%	The wavefile to be decoded is expected to be a 16bit windows .WAV file
%	call RX.WAV
%
%	The data expected is that generated using genrand.m, having the
%	random seed set to 123456 before it is generated.
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
%
%	29/7/97	11:48am cofdmrd.m
%	Modifed cofdmwav.m so that it now decodes the wav sound file.
%
%	2/8/97	10:25pm	imagerx.m
%	Fixed an algorithum error for picking the starting time of the frames.
%	I was using the normal start time, as for single frame simulations, which
%	meant that only early frame start time errors could only with out causing
%	error. This was fixed by picking the start time early by 1/4 of the
%	guard time (1/2 the time of the cyclic extension of the symbol), thus
%	allowing a start time error of +- 1/4 guard time.
%
%	3/8/97	2:00pm imagerx.m
%	Added the option of compressing the contrast of the picture
%	to help prevent roll over of intensity when sending 8bits/word.
%	Also added data averaging, allowing duplicates of data to
%	be sent and recombined to reduce the phase error. This works,
%	except for it giving errors for black pixels.
%
%	12/8/97 10:30pm imagerx.m
%	Made many changes to the structure of the program. It can now receive
%	random data, pictures, and general binary files. Both the random data
%	and picture transmission appears to mostly work, however the
%	data padding for data sets which are not multiples of the number of
%	carriers doesn't work yet.Also a common setting script is now used
%	for both the transmitter and receiver. This is settings.m.
%
%	17/8/97 2:00 pm imagetx.m
%	Moved the calculation of the carriers to use into the settings
%	script.

%======================================================
%	External functions required to run this script:
%	wread16.m 		(from the Matlab web site)
%	calcerr.m
%	settings.m
%	rddatatx.m
%	findfrm.m
%	receive.m
%	convbase.m
%	bmpread.m
%	bmpwrite.m
%	wrimage.m
%	wavwrite.m

clear all;
flops(0);
tic;			%Measure the time it takes to run the simulation
settings		%Setup the link parameters
%=====================
%Read in the .wav file
%=====================
SignalIn = wavread(rxwavfile);

%======================================================
%Read in the picture to be received to check for errors
%======================================================
%Read the picture with no data averaging to get just the picture data
%[Datatx,h,w] = rdimage(filename,PictureComp);
rddatatx	%Read the data which was transmitted. This sets up data
		%transmitted (DataIn) and Datatx, and the height (h) and width (w)
		%of the original data
TotNoData = h*w;
NoData = h*w;
switch guardtype
case 1
	%Zeroed guard period
	FrameGap = ifftsize+guardtime*2;
	zerotime = guardtime;
case 2
	FrameGap = ifftsize+guardtime;
	zerotime = 0;
case 3
	FrameGap = ifftsize+3*guardtime/2;
	zerotime = guardtime/2;
end
if SymbPerFrame ~= 0,
	SampPerFrame = (SymbPerFrame+1)*(ifftsize+guardtime);

	
	SignalLeft = SignalIn;
	Finished = 0;
	AllData = [];
	AllDiff = [];
	First = 1;
	if fileknown == 0,
		%Don't know how many frames so estimate from the number of samples 
		NumFrames = floor((length(SignalIn)/(SampPerFrame)));
		disp(['Estimating the number of frames as : ' int2str(NumFrames)]);
	else
		NumFrames = ceil(((TotNoData*(OutWordSize/wordsize))...
				*DataAvg/NumCarr)/SymbPerFrame);
	end
	for k = 1:NumFrames,
		disp(['Decoding Frame : ', num2str(k)]);
		%FrameCount = FrameCount+1;
		if First == 1,
			First = 0;

			Signal = SignalLeft(1:min(SampPerFrame*1.1,length(SignalLeft)));
			Scale = ([0:length(Signal)-1]/length(Signal)*mean(abs(Signal))).';
			Signal = Signal+Scale;

		else
			Signal = SignalLeft(1:min(FrameGap*3,length(SignalLeft)));
		end

		FrameStart = findfrm(Signal, FrameGap, quickrate,zerotime);

		FrameStart = FrameStart - guardtime/4;
		Signal =SignalLeft(FrameStart:...
			min(FrameStart+SampPerFrame,length(SignalLeft)));

		if k == NumFrames,
			Finished = 1;
			NoData = TotNoData;
		else
			SignalLeft = SignalLeft(...
				FrameStart+SampPerFrame-FrameGap*1.5:length(SignalLeft));
			plot(SignalLeft);
			TotNoData = TotNoData - SymbPerFrame*NumCarr/...
				(OutWordSize/wordsize)/DataAvg;
			NoData = floor(SymbPerFrame *NumCarr/(OutWordSize/wordsize)/DataAvg);
		end

		[Datarx, DiffPhRx] = receive(Signal,ifftsize,carriers,...
		 wordsize,guardtype,guardtime,DataAvg,NoData);
		AllDiff = [AllDiff DiffPhRx];
		AllData = [AllData Datarx];
	end
	DiffPhRx = AllDiff;
	Datarx = AllData;
else
	TotalWords = ceil((h*w*(OutWordSize/wordsize)*DataAvg)/NumCarr)*NumCarr;
	%===============================================================
	%Try to detect the start of a frame by envelop detection & filtering
	%===============================================================
	%Calc number of samples in a frame, no including the frame sync guard period
	SampPerFrame=((TotalWords/NumCarr)+1)*(ifftsize+guardtime);

	%Calc number of sample in a frame guard period
	SampPerFrmGrd = FrameGuard;

	disp('Searching for start of frame');
	disp('    -Filtered Signal');
	%FrameGap = ifftsize+3*guardtime/2;
	%zerotime = guardtime/2;
	FrameStart = findfrm(SignalIn(1:length(SignalIn)/2), FrameGap, quickrate,zerotime);
	FrameStart = FrameStart - guardtime/4;
	%cut out one frame to decode
	BaseSignal = SignalIn(FrameStart:FrameStart+SampPerFrame)/(2^15);
	disp('Decoding COFDM frame');



	%===============================
	%Decode the received COFDM frame
	%===============================
	[Datarx, DiffPhRx] = receive(BaseSignal,ifftsize,carriers,...
		 wordsize,guardtype,guardtime,DataAvg,NoData);
end

if (size(Datatx) == size(Datarx)),
	[PhError, Summary] = calcerr(Datatx,Datarx,DiffPhRx,wordsize);
	disp(['BER = ',num2str(Summary(1)),'    RMS phase error = ' num2str(Summary(2)),...
	'    Total number of errors = ', num2str(Summary(3))]);
else
	disp('WARNING: Length of received data does not match the transmitted length');
	disp(['length of transmitted data : ' int2str(length(Datatx))]);
	disp(['length of received data : ' int2str(length(Datarx))]);
end

Datarx = convbase(Datarx, wordsize, OutWordSize);
if DataType == 2,
	[x2,map] = bmpread(infile);
	%outfile = [outfile, num2str(SNR), 'db.bmp'];
	x=wrimage(Datarx,h,w,outfile,PictureComp);

	figure(1);
	image(x);
	colormap(map);
	title('Received image');


	figure(2);
	image(x2-1);
	colormap(map);
	title('Original Transmitted image');

	figure(3);
	colormap(map);
	image((x2-x)*8+128);
	title('Error in received image (Contrast Enhanced)');

	%errorfile = [errorfile, num2str(SNR), 'db.bmp'];

	bmpwrite(((x2-x)*8+128),map,errorfile);
	RmsAmpErr=mean(std(x2-1-x));	%RMS amplitude error of the picture
	RmsAmp = mean(std(x2));	%RMS amplitude of the original picutre
	SNRpic = 20*log10(RmsAmp/RmsAmpErr);
	disp(['SNR of the received image : ', num2str(SNRpic), ' dB']);
elseif DataType == 3,
	if OutWordSize == 8,
		DataSize = 'integer*1';
	elseif OutWordSize == 16,
		DataSize = 'integer*2';
	else
		error('OutWordSize no valid for sending binary files, must be 8 or 16');
	end
	fid = fopen(outfile,'wb');
	fwrite(fid,Datarx,DataSize);
	fclose(fid);
elseif DataType == 4,
	wavwrite(Datarx/(2^(OutWordSize)+1),fs,OutWordSize,outfile);
end
disp(['Total Time: ' num2str(toc) 'sec']);
disp(['Total FLOPS: ' num2str(flops)]);
disp(['Process Speed : ' num2str(flops/toc) ' flops/sec']);


