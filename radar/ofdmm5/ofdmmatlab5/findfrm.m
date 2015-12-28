function FrameStart= findfrm(SignalIn, FrameGap, quickrate,zerotime)
%FINDFRM Finds the start of a COFDM frame
%	FrameStart = findfrm(SignalIn, FrameGap, quickrate,zerotime)
%	Find the approximate starting location
%	zerotime : zeroed time of the guard period
%	Copyright Eric Lawrey 1997
%

SignalIn = abs(SignalIn);		%Envelope detect the signal

%=========================================
% Subsample to find approx start location
%=========================================
index = 1:quickrate:length(SignalIn);
SubSignal = SignalIn(index);	%Subsample the signal
SubFilt = filter(ones(1,round(FrameGap/quickrate)),1,SubSignal);
SearchSig1 = SubFilt(round(FrameGap/quickrate):length(SubFilt));
approxstart = min((find(SearchSig1==min(SearchSig1))+...
		FrameGap/quickrate)*quickrate-zerotime);
%plot(SearchSig1);
%============================================================
% Narrow down the search to find the exact starting location
%============================================================
Offset = round(approxstart-1.1*FrameGap);	%Starting location of accurate search
EnvFilt = filter(ones(1,FrameGap),1,...
	  SignalIn(Offset:round(approxstart+FrameGap/3)));
%plot(EnvFilt);

%============================================================================
%Find the minimum of the integral ensuring that it is at least one frame time
%before the end of the wave file. (ignore the first symbol period)
%============================================================================
SearchSig = EnvFilt(FrameGap:length(EnvFilt));
minsig = find(SearchSig==min(SearchSig))+FrameGap;

%Calc the expect start of the frame
%Pick the frame start just before the normal starting time to allow for timming
%errors in both directions, i.e. early and late
FrameStart = min(minsig-zerotime+Offset);
CalcStart = FrameStart;
