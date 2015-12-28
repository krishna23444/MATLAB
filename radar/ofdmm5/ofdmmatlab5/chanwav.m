Comp = 0;
SNR = 300;
Delay = 4;
MultiMag = 0.95;
rxwavfile = 'corrs11.wav';
txwavfile = 'out.wav';

Multi = zeros(Delay,1);
Multi(1) = 1;
Multi(Delay) = MultiMag;
%=====================
%Read in the .wav file
%=====================
[TimeSignal, Fs] = wread16(rxwavfile);
TimeSignal = channel(TimeSignal, Comp, SNR, Multi);
%==============================
%Save the signal as a .WAV file
%==============================
wavwr(TimeSignal,Fs,8,1,txwavfile);
