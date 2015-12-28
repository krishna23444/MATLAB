% Example of header and annotation files reading for MIT record

recname='100';

% Reading header information
heasig=readheader([recname '.hea']);

% Reading annotation file
t=[1 50000];  % time interval [onset offet]
annot=readannot([recname '.atr'],t);

% reading ECG signal file with format 212
if heasig.fmt(1)==212
   ecg=rdsign212([recname '.dat'],heasig.nsig,t(1),t(2));
end
