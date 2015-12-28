function [PhError, Summary] = calcerr(Datatx,Datarx,DiffPhRx,wordsize)
%CALCERR Calculates the phase error, BER, and standard deviation of the error
%
% 	 [PhError, Summary] = calcerr(Datatx,Datarx,DiffPhRx,wordsize)
%	 Summary contains all the relevent error statistics:
%	 Summary = [BER, StdErr, NumErr]
%	 
%	 Copyright (c) Eric Lawrey 1997

%Modifications:
%	18/6/97 Inital write up of the function.

%======================================
%Investigate the phase error 
%comparing tx phase and recovered phase
%======================================
PhInc = 360/(2^wordsize);		%Find the increment between the phase locations
DiffPhTx = Datatx*PhInc;

PhError = (DiffPhRx - DiffPhTx);	%find phase error in degrees
%Make all errors -180deg to 180deg
l=find(PhError>180);
PhError(l) = PhError(l)-360;	
l=find(PhError<=-180);
PhError(l) = PhError(l)+360;	
StdErr = std(reshape(PhError,1,size(PhError,1)*size(PhError,2)));
	
%=====================================
%Calculate the BER
%=====================================
Errors = find(Datatx-Datarx);
NumErr = length(Errors);
NumData=size(Datarx,1)*size(Datarx,2);	%find the total number of data sent
BER = NumErr/NumData;
Summary = [BER,StdErr,NumErr];
	