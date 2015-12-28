% Reads a Philips SPAR file to get the parameters. 
clear all;
close all;
fid = fopen('31P_2D_PULACQ_LFC-RFC_10_1_raw_act.SPAR','r');
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    disp(tline)
end
fclose(fid);


% fid = fopen('Data1.SPAR','r');
% comments = fread(fid,579,'*char');
% examination_name = fread(fid,24,'*char');
% scan_id = fread(fid,16,'*char');
% fclose(fid);