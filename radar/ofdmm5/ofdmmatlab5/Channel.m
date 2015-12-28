function OutSignal = channel(TimeSignal,clipcompress,SNR,Multipath)
% CHANNEL Applies a channel model to the waveform including, noise, multipath & clipping.
%
%	OutSignal = channel(TimeSignal,clipcompress,SNR,Multipath)
%
%	The model is the simulate some of the effects of a radio channel. For this reason,
%	the effects are applied in the following order : 
%	1. Clipping  : Effect from the output power amplifier.
%	2. Noise     : Thermal noise due to the channel.
%	3. Multipath : Channel effect at the receiver.
%
%	INPUTS:
%	TimeSignal   :	Time waveform of signal to apply the channel to.
%	clipcompress :	Amount of clipping to apply to the signal, in dB
%			Peak Power of original signal / Peak Power after clipping.	
%			if no clipping is needed choos clipcompress = 0.
%	SNR	     :	SNR of the transmitted signal, in dB,
%			RMS power of original signal / RMS power of noise to be added.
%			if no noise is needed choose SNR >= 300.
%	Multipath    :	This is a vector of the magnitude and delay for each reflection.
%			This is a coefficient vector for  modelling the multipath with an
%			FIR filter. The first coefficient must be 1 if a direct signal is 
%			needed.
%			For Example : for reflections at sample times : 5 & 7 with magnitude
%			of 50% & 30% respectively of the direct signal :
%			Multipath = [1 0 0 0 0 0.5 0 0.3]
%			If no multipath effect is needed make 'Multipath' = []
%	OUTPUTS:
%	OutSignal    : Output signal after the model.
%
%	Copyright (c) Eric Lawrey 1997

%	Modifications:
%	17/6/97 : Started working on the function.

%================================
%Clip the signal
%================================
if clipcompress ~= 0,
	MaxAmp = (10^(0-(clipcompress/20)))*max(TimeSignal);
	TimeSignal(find(TimeSignal>=MaxAmp))=ones(1,length(find(TimeSignal>=MaxAmp)))*MaxAmp;
	TimeSignal(find(TimeSignal<=(-MaxAmp)))=ones(1,length(find(TimeSignal<=(-MaxAmp))))*(-MaxAmp);
%	PeaktoRms = 10*log10(max(TimeSignal.^2)/(std(TimeSignal)^2));
end
%================================	
%Add noise
%================================
if SNR < 300,
	
	SigPow = std(TimeSignal);	%find the signal power
	NoiseFac = 10^(0-(SNR/20));
	TimeSignal = TimeSignal + randn(1,length(TimeSignal))*SigPow*NoiseFac; 
end

%================================
%Add multipath
%================================
if isempty(Multipath)
	TimeSignal = filter(Multipath,1,TimeSignal);	%add multi path to the signal
end

OutSignal = TimeSignal;