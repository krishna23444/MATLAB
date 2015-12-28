function functionTesting
% FUNCTIONTESTING
% This file is used to test the functions created in the EW Toolbox.
% 
% Author Jason Moyle

%% Initialise
clear all
global wrongFunc
clc
wrongFunc=0;    % Incorrect function counter
%% AE test
a=ae(.03,1000,65);
a=round(a*1e4)/1e4;
if a~=.1102
    disp('ae function with eta incorrect')
    wrongFunc=wrongFunc+1;
end
a=ae(.03,10);
a=round(a*1e7)/1e7;
if a~=7.162e-4
    disp('ae function without eta incorrect')
    wrongFunc=wrongFunc+1;
end
%% AEG test
G=aeg(.07162,.03,65);
G=round(G*1e4)/1e4;
if G~=650.0025
    disp('aeg function with eta incorrect')
    wrongFunc=wrongFunc+1;
end
a=aeg(7.162e-2,.03);
G=round(a*1e4)/1e4;
if G~=1000.0038
    disp('aeg function without eta incorrect')
    wrongFunc=wrongFunc+1;
end

%% ANGLE SEARCH test
b=[3.1,3.45,3.5;3.4,3,2;3.42,7,9];
a=angleSearch(b);
if a~=3.42
    disp('angleSearch function incorrect')
    wrongFunc=wrongFunc+1;
end

%% ESVRDR test
[esadv,rRange,esRange,rsmin,essmin]=esVrdr(5e3,1000,1000,...
    3,1,1e-6,1e9,4,14,9.5e9);
results=[esadv rRange esRange rsmin essmin];
expected=[31437.6308 2284.8770 33722.5078 -95.5703 -75.5703];
check(results,expected,4,'esVrdr')

%% INTERFEROMETER TEST
myangle=aoaInter([193 87],[.5 .6],3e9);
ang=round(myangle*1e4)/1e4;
if ang~=44.9472
    disp('aoaInter function incorrect')
    wrongFunc=wrongFunc+1;
end

%% KT2KMH Knots to km/hr test
% expect 333.3600 km/hr
kmphr=kt2kmh(180);
kmphr=round(kmphr*1e4)/1e4;
if kmphr~=333.3600
    disp('kt2km function incorrect')
    wrongFunc=wrongFunc+1;
end

%% KT2MS Knots to m/s test
% expect 0.5144 m/s
ms=kt2ms(1);
ms=round(ms*1e4)/1e4;
if ms~=0.5144
    disp('kt2ms function incorrect')
    wrongFunc=wrongFunc+1;
end

%% KMH2MS km/hr to m/s test
% expect  27.7778 m/s
mps=kmh2ms(100);
mps=round(mps*1e4)/1e4;
if mps~=27.7778
    disp('kmh2ms function incorrect')
    wrongFunc=wrongFunc+1;
end

%% RCSCHAFF Max RCS Chaff Dipole
% expect  0.000774 m^2
rcscd=rcsChaff(10e9);
rcscd=round(rcscd*1e6)/1e6;
if rcscd~=0.000773
    disp('rcsChaff function incorrect')
    wrongFunc=wrongFunc+1;
end

%% RMAXDB Max radar range
% expect  38.39 dB
rmax=rmaxdb(-120,37,30,30,5,10e9);
rmax=round(rmax*1e4)/1e4;
if rmax~=39.6400
    disp('rmaxdb function incorrect')
    wrongFunc=wrongFunc+1;
end

%% TDOA test
% could expand this test to look at each returned result and output which
% one is wrong. Also haven't looked at multiple time inputs.
[d ed r er]=tdoa(15e-9,5);
results=round([d ed r er].*1e4)./1e4;
if results(1)~=64.0763||results(2)~=7.8581||results(3)~=1.1183||results(4)~=0.1372
    disp('tdoa function incorrect')
    wrongFunc=wrongFunc+1;
end

%% TDOA ERROR test
% could expand this test to look at each returned result and output which
% one is wrong. Also haven't looked at multiple time inputs.
[de re]=tdoaerr(45,1e-9,15);
results=round([de re].*1e4)./1e4;
if results(1)~=1.6194||results(2)~=0.0283
    disp('tdoaerr function incorrect')
    wrongFunc=wrongFunc+1;
end

%% TTI test
% expect 6.5 ms
t=tti(10e-6,1e-6,983e-6,50);
t=round(t*1e4)/1e4;
if t~=.0065
    disp('tti function incorrect')
    wrongFunc=wrongFunc+1;
end

% Tests check function
% a(1)=p2b(10);
% a(2)=p2b(100);
% check(a,[.1 .01],2,'myCheck')
%% Output number of functions in error

fprintf('\nThe number of functions in error is: %d\n\n',wrongFunc)
% Subfunction for checking 
function check(obtained,expected,decimalPlaces,name)
% CHECK checks if results obtained are the same as those expected
%   obtained = results obtained from calling function
%   expected = Rounded results that are expected
%   decimalPlaces = number of decimal places to which accuracy is required
%   name = name of function
global wrongFunc
if (length(expected)~=length(obtained))
    error('When checking, expected and obtained array lengths differ.')
end
dec=decimalPlaces;
for i=1:length(expected)
    result=round(obtained(i)*10^dec)/10^dec;
    correctResult=expected(i);
    if result~=correctResult
        wrongFunc=wrongFunc+1;
        fprintf('\n%s function incorrect\n',name)
        return
    end
end