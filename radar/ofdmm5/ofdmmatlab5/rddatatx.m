%RDDATATX This Script reads in the data to transmit. It is used by
%	both the transmit and receive scripts. The transmitter script
%	runs this script to find what data to transmit. the receiver
%	runs this script so that it can compare the received data
%	with the transmitted data, allowing detection of errors.

%	12/8/97 Initial write up (Appears to work)
%	genrand.m
%	rdimage.m
%	convbase.m

%=====================
%Read Data to transmit
%=====================
if DataType == 1,
	%Use random data.
	DataIn = genrand(1,OutWordSize,NoRandData,RandSeed);
	disp(['Transmitting : ', num2str(NoRandData),' Random data words']);

	%Data format structure. This is passed to the receiver in a file
	%as it critical for reconstructing the data. This is needed as there
	%is no datalink layer in the COFDM transmission.
	%For Sending random data and a general binary file the data is sent
	%as a serial byte stream, thus the DataHeight is 1 and the DataWidth is
	%equal to the number of bytes sent.
	h = 1;			%Height of the data structure (in bytes)
	w = NoRandData;	%Width of the data structure (in bytes)

elseif DataType == 2,
	%Transmit a grey scale bitmap image.
	[DataIn,h,w] = rdimage(infile,PictureComp);
	disp(['Image Dimensions are : ',num2str(h),'x',num2str(w)]);

	%For a grey scale bmp image the shape of the image set the data height
	%and width

	if OutWordSize ~= 8,
		disp('Warning, OutWordSize is not 8 bit thus the image wont be decoded properly');
	end
elseif DataType == 3,
	%Transmit a general binary file
	fid = fopen(infile,'r');
	if fid ~= -1,
		DataIn = fread(fid)';
	else
		error('Error opening the input data file, check file name');
	end
	fclose(fid);
	%For Sending a general binary file the data is sent as a serial byte stream,
	%thus the DataHeight is 1 and the DataWidth is equal to the number of bytes
	%sent.
	h = 1;			%Height of the data structure (in bytes)
	w = length(DataIn);	%Width of the data structure (in bytes)
	if OutWordSize ~= 8,
		disp('Warning, OutWordSize is not 8 bit thus the image wont be decoded properly');
	end

elseif DataType == 4,
	%Transmit a windows 3.1 .WAV file
	[DataIn fs Nbits] = wavread(infile);
	if Nbits == 8
		DataIn = round((DataIn*128+128).');
	else
		DataIn = round(DataIn.'*32768);
	end

	%DataIn = DataIn';
	h = 1;
	w = length(DataIn);
else
	error('DataType is not valid, it must be from 1-4');
end
%Convert from the data from the normal wordsize (typically 8bits) to the wordsize
%used for transmission (typically 2bits for QPSK)
Datatx = convbase(DataIn,OutWordSize,wordsize);
