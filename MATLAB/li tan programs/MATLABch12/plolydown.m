close all; clear all;
% This program is the polyphase implementation for Figure 12.1.3b.
% down sampling filter  ( see Chapter 7  for FIR filter design)
B =[0.00074961181416   0.00247663033476   0.00146938649416  -0.00440446121505 ...
  -0.00910635730662   0.00000000000000   0.02035676831506   0.02233710562885...
  -0.01712963672810  -0.06376620649567  -0.03590670035210   0.10660980550088...
  0.29014909103794   0.37500000000000   0.29014909103794   0.10660980550088...
  -0.03590670035210  -0.06376620649567  -0.01712963672810   0.02233710562885...
  0.02035676831506   0.00000000000000  -0.00910635730662  -0.00440446121505...
  0.00146938649416   0.00247663033476   0.00074961181416];
% generate 2048 samples
fs=8000;                                           % sampling rate
N=2048;                                           % number of samples 
M=2;                                              % down sample factor
n=0:1:N-1;
x=5*sin(n*pi/4)+cos(5*n*pi/8);
% compute single-side amplitude spectrum 
% AC component will be doubled, and DC component will be kept as the same
X=2*abs(fft(x,N))/N;X(1)=X(1)/2; 
% map the frequency index  up to the folding frequency to the frequency in Hz
f=[0:1:N/2-1]*fs/N;    
%polyphase implementation of decimation begins
p0=B(1:M:length(B));  % filter bank 0
p1=B(2:M:length(B));  % filter bank 1
w0=x(1:M:length(x)); % channe 0 is down sampled by M
w1=filter([0 1],1,x); % delay by one sample
w1=w1(1:M:length(w1));  % channel 1 is down sampled by M
y0=filter(p0,1,w0);
y1=filter(p1,1,w1);
y=y0+y1;             % decimated signal output
%polyphase implenenttaion ends
NM=length(y);
% compute single-side amplitude spectrum for the down sampled signal
Y=2*abs(fft(y,NM))/NM;Y(1)=Y(1)/2;
fsM=[0:1:NM/2-1]*fs/(M*NM);  
% plot spectrums
subplot(2,1,1);plot(f,X(1:1:N/2));grid; xlabel('Frequency (Hz)');ylabel('Input sepctrum');
subplot(2,1,2);plot(fsM,Y(1:1:NM/2));grid; xlabel('Frequency (Hz)');ylabel('Downsampled spectrum');
