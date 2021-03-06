clc
clear all
%------ SPECIFY DATA ------------------------------------------------------
PATH= 'D:\MATLAB 2010 Portable\bin\DD\ecgsim1'; % path, where data are saved
HEADERFILE= '208.hea';      % header-file in text format
ATRFILE=    '208.atr';         % attributes-file in binary format
DATAFILE=   '208.dat';         % data-file
str=360*1562;
stp=360*1568;
SAMPLES2READ=stp+1;% number of samples to be read
     sel=1;                       % 2*SAMPLES2READ samples are read

%------ LOAD HEADER DATA --------------------------------------------------
fprintf(1,'\\n$> WORKING ON %s ...\n', HEADERFILE);
signalh= fullfile(PATH, HEADERFILE);
fid1=fopen(signalh,'r');
z= fgetl(fid1);
A= sscanf(z, '%*s %d %d %d',[1,3]);
nosig= A(1);  % number of signals
sfreq=A(2);   % sample rate of data
clear A;
for k=1:nosig
    z= fgetl(fid1);
    A= sscanf(z, '%*s %d %d %d %d %d',[1,5]);
    dformat(k)= A(1);           % format; here only 212 is allowed
    gain(k)= A(2);              % number of integers per mV
    bitres(k)= A(3);            % bitresolution
    zerovalue(k)= A(4);         % integer value of ECG zero point
    firstvalue(k)= A(5);        % first integer value of signal (to test for errors)
end;
fclose(fid1);
clear A;

%------ LOAD BINARY DATA --------------------------------------------------
if dformat~= [212,212], error('this script does not apply binary formats different to 212.'); end;
signald= fullfile(PATH, DATAFILE);            % data in format 212
fid2=fopen(signald,'r');
A1= fread(fid2, [3, SAMPLES2READ], 'uint8')';  % matrix with 3 rows, each 8 bits long, = 2*12bit
fclose(fid2);
M2H= bitshift(A1(:,2), -4);
M1H= bitand(A1(:,2), 15);
PRL=bitshift(bitand(A1(:,2),8),9);     % sign-bit
PRR=bitshift(bitand(A1(:,2),128),5);   % sign-bit
M( : , 1)= bitshift(M1H,8)+ A1(:,1)-PRL;
M( : , 2)= bitshift(M2H,8)+ A1(:,3)-PRR;
if M(1,:) ~= firstvalue, error('inconsistency in the first bit values'); end;
switch nosig
case 2
    M( : , 1)= (M( : , 1)- zerovalue(1))/gain(1);
    M( : , 2)= (M( : , 2)- zerovalue(2))/gain(2);
    TIME=(0:(SAMPLES2READ-1))/sfreq;
case 1
    M( : , 1)= (M( : , 1)- zerovalue(1));
    M( : , 2)= (M( : , 2)- zerovalue(1));
    M=M';
    M(1)=[];
    sM=size(M);
    sM=sM(2)+1;
    M(sM)=0;
    M=M';
    M=M/gain(1);
    TIME=(0:2*(SAMPLES2READ)-1)/sfreq;
otherwise  % this case did not appear up to now!
    % here M has to be sorted!!!
    disp('Sorting algorithm for more than 2 signals not programmed yet!');
end;
clear A M1H M2H PRR PRL;
fprintf(1,'\\n$> LOADING DATA FINISHED \n');

%------ LOAD ATTRIBUTES DATA ----------------------------------------------
atrd= fullfile(PATH, ATRFILE);      % attribute file with annotation data
fid3=fopen(atrd,'r');
A= fread(fid3, [2, inf], 'uint8')';
fclose(fid3);
ATRTIME=[];
ANNOT=[];
sa=size(A);
saa=sa(1);
i=1;
while i<=saa
    annoth=bitshift(A(i,2),-2);
    if annoth==59
        ANNOT=[ANNOT;bitshift(A(i+3,2),-2)];
        ATRTIME=[ATRTIME;A(i+2,1)+bitshift(A(i+2,2),8)+...
                bitshift(A(i+1,1),16)+bitshift(A(i+1,2),24)];
        i=i+3;
    elseif annoth==60
        % nothing to do!
    elseif annoth==61
        % nothing to do!
    elseif annoth==62
        % nothing to do!
    elseif annoth==63
        hilfe=bitshift(bitand(A(i,2),3),8)+A(i,1);
        hilfe=hilfe+mod(hilfe,2);
        i=i+hilfe/2;
    else
        ATRTIME=[ATRTIME;bitshift(bitand(A(i,2),3),8)+A(i,1)];
        ANNOT=[ANNOT;bitshift(A(i,2),-2)];
   end;
   i=i+1;
end;
ANNOT(length(ANNOT))=[];       % last line = EOF (=0)
ATRTIME(length(ATRTIME))=[];   % last line = EOF
clear A;
ATRTIME= (cumsum(ATRTIME))/sfreq;
ind= find(ATRTIME <= TIME(end));
ATRTIMED= ATRTIME(ind);
ANNOT=round(ANNOT);
ANNOTD= ANNOT(ind);



load('D:\MATLAB 2010 Portable\bin\DD\ecgsim1\Numbp.mat')
hh=Numbp;

bb=filter(hh,1,M(str:stp,sel));

for kl=2:length(M(str:stp,sel).')-1
    bc(kl)=(bb(kl+1)-bb(kl-1))/2;
    
end
bc(1)=bb(2)/2;
bc(length(M(str:stp,sel).'))=-(bb(length(M(str:stp,sel).')-1))/2;

for kl=1:length(bc)-1
    bx(kl)=(bc(kl+1)-bc(kl))/2;
    
end
bx(length(bc))=bc(length(bc))/2;

%  figure(1)
%     plot(TIME(360*1563:360*1567), M(360*1563:360*1567,sel),'r')
 figure(3)

 plot(TIME(360*1563:360*1567),bx(361:length(bx)-360),'r');
  title('2 stage 2nd derivative')


