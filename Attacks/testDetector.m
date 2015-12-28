% IMPORTANT:  the executedetector script MUST be customized 
% for this script to work correctly

% store the current directory
a1=pwd;SETUP=getconfig(0);

% IMPORTANT: NO SPACES in Technology Name
TechnologyName=char(SETUP.techname);
applicname=char(SETUP.applicname);

% set the basepath. 
imagepath=SETUP.imagepath;

% the attacked images are in imagepath\ATTACKED
fprintf('using the attacked images in the directory ... \n')
dir1=strcat(imagepath,SETUP.attackedsubdir)

% the results are stored in xmlFname in the checkmark Path
fprintf('results will be stored in... \n')
xmlFname=[SETUP.checkmarkPath TechnologyName '_' applicname '.xml']

fprintf('\nchanging to directory with attacked images... \n')
%fprintf('\nNOTE: detector must be in the Path!!!\n')

com1=sprintf('cd %s',dir1);  eval(com1);

numims=SETUP.numims;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% base directory for the detector's files
% test the detector and write the xml file with the results

xmlfid=fopen(xmlFname,'w');XML_writeHeader(xmlfid);
CM_version=checkmarkversion(0);

starttagref(xmlfid,'technology',TechnologyName);
inserttag(xmlfid,'Checkmark_Version',CM_version);
% the original images are called t1bw.jpg ... t5bw.jpg
% the watermarked images are called t1bwWM.jpg ... t5bwWM.jpg
% the originals are needed to compute the quality metrics
str1=sprintf('*.jpg',i);dirstruct1 = dir(str1);

for i=1:numims
  imin=[imagepath SETUP.origImage int2str(i) '.jpg']
  imwm=[imagepath SETUP.WMimage int2str(i) '.jpg']
  imO=double(imread(imin));  % original
  im1=double(imread(imwm));  % watermarked image
  str2=sprintf('im%d',i); prefixLength=size(str2,2);
  starttagref(xmlfid,'image',str2);
  

  writeQualityMetrics(xmlfid,imO,im1);
  % for each attacked image run the detector
  % assumes the attacked image names start by im1, im2...
 
 
  
  tmp1=strvcat(dirstruct1(:).name);
  inds=strmatch(str2,tmp1);dirstruct=tmp1(inds,:);
  numfiles=size(dirstruct,1);
  for j=1:numfiles % all files are jpg files
    fname=deblank(char(dirstruct(j,:)));
    fprintf('\nChecking image # %d/%d (%s), attack # %d/%d %s \n\n', i, numims, imwm, j, numfiles, fname);   
							   
    % %%%%%%%%%%customize the following function
    %which should return 1 or 0 depending on response
    detectionresult=executedetector(fname);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CHECK for COPY ATTACK and INVERT RESPONSE
    % that is if the watermark is detected the score should be 0
    if ~isempty(findstr('copy',fname))
      sprintf('inverting detector result for copy attack...')
      detectionresult=1-detectionresult
    end
    fname=fname(prefixLength+1:end);
    inserttag2(xmlfid,'attack',fname,detectionresult);
  end
  endtag(xmlfid,'image');
end
endtag(xmlfid,'technology');fclose(xmlfid);
com1=sprintf('cd %s',a1);eval(com1);
sprintf('completed testing of detector, use the script parse results')
sprintf('to generate final results')