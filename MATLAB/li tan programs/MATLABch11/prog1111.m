%MATLAB Program 11.11
%this program is written for off-line simulation 
clear all; close all
load we.dat  % provided by the instructor
speech=we;
desig= speech;
lg=length(desig);                               % length of speech data
enc = adpcmenc(desig);                    % ADPCM encoding
%ADPCM finished
dec = adpcmdec(enc);                       % ADPCM decoding 
snrvalue = snr(desig,dec)               % calculate signal to noise ratio due to quantization
subplot(3,1,1);plot(desig);grid;
ylabel('Speech');axis([0 lg -8000 8000]);
subplot(3,1,2);plot(dec);grid;
ylabel('Quantized speech');axis([0 lg -8000 8000]);
subplot(3,1,3);plot(desig-dec);grid
ylabel('Quantized error');xlabel('Sample number');
axis([0 lg -1200 1200]);
