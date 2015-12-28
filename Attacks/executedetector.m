
% This function should be cutomized so that it calls the detector
% given a filename.  The function should return 0 or 1 depending
% on if the watermark is detected or not.
% two examples of how this function might be customized
% for typical detectors seleceted by detectortype
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
function detectionresult=executedetector(fname,detectortype)

if exist('detectortype')~=1
  detectortype=1;
end

switch detectortype
 case 1, %typical code for an executable program writing to stdout
  resFname='tmp.txt'; % temp file used by detector
  com1=sprintf('!..\\eversignshell -R %s> %s',fname,resFname)
  eval(com1)
  
  %%%%%%%%%%%%%%%%%%%%%
  % parse the output file to obtain a yes or no answer for the
  % watermark
  %fid=fopen(resFname,'r');
  file = textread(resFname,'%s','delimiter','\n','whitespace','');
  val=strmatch('Image is watermarked',file);
  if ~isempty(val)
    detectionresult=1
  else
    detectionresult=0
  end
  return
 case 2, % a typical matlab detector
% add paths if necessary
  addpath   c:/shelby/matlab/dct_realtim2/
  addpath   c:/shelby/matlab/dct_realtim2/turboc
  [wmfound]=dctdetect(fname);
  if (wmfound==1) 
    detectionresult=1;
  else
    detectionresult=0;
  end
 
end
