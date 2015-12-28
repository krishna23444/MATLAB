function [rate SNRq SNRqdb]=datarate(freq,bitsPerSample,buffer)
% DATARATE Data rate, bytes per minute storage
% 
%   [rate SNRq SNRqdb]=datarate(freq,bitsPerSample,buffer)
% 
%   OUTPUTS
%   rate   = number of bytes per minute capable of being stored [bytes/min]
%   SNRq   = signal to quantisation level [1]
%   SNRqdb = signal to quantisation dB equivalent [dB]
% 
%   INPUTS
%   freq          = Frequency of the signal to be digitised [Hz]
%   bitsPerSample = Number of bits per sample [1]
%   buffer        = bandwidth allowance desired [%]
% 
%   AIM:
%   To find the data rate capacity when digitizing a signal, along with the
%   signal to noise level. This signal to noise is actually a signla to
%   quantisation level.
% 
%   TECHNICAL BACKGROUND:
%   Electronic Intelligence (ELINT) information can be recorded on hard
%   disk drives. To do this an analog signal first needs to be digitised.
%   To digitise a signal, it should be sampled at twice the frequency of
%   the signal to avoid alias signals. An alias signal is one that is
%   caused when undersampling a signal; the representation is not the
%   correct signal. A sample rate of twice the frequency is know as the
%   Nyquist rate.
%   The signal to noise is associated with the number of bits per sample.
%   It is actually a peak signal power to average quantisation noise power,
%   therefore known as signal to quantisation power.
% 
%   REFERENCES:
%   Benson, Frater, Ryan, TACTIACL ELECTRONIC WARFARE, Argoss Press, 2007,
%   pp.224,225.
%   Adamy, INTRO TO EW MODELLING AND SIMULATION, Artech house, 2003,
%   pp.80,81
%   Sklar, DIGITAL COMMUNICATIONS, Prentice-Hall, 2006, p.79
% 
%   AUTHOR: Jason Moyle
%   DATE: September 2008
%   
% TODO: check spelling digitise quantise

%   Copyright 2008 by Jason Moyle

%% Initiate variables
samprate=2;             % Sampling rate or Nyquist
byte=8;                 % Bits per byte
allow=(1+buffer/100);   % Bandwidth allowance
min=60;                 % Seconds per minute
f=freq;                 % Frequency of the signal to be digitised
m=bitsPerSample;        % Number of bits per sample

%% Calculate data rate
rate=freq*samprate*bitsPerSample/byte*allow*min;

%% Calculate signal to quantisation noise
snr=3*2^(2*m-1);        % SNR associated with bits per sample
SNRq=samprate*snr;      % Peak signal power to average quantisation noise 
                        %   power
SNRqdb=g2db(SNRq);      % dB version of above                        