% SimEx1.m
%
% This script recreates parts of Simulated Example 1 from "Space-Time Event
% Sparse Penalization for Magneto-/Electroencephalography," NeuroImage
% 46(4) (2009).  http://dx.doi.org/10.1016/j.neuroimage.2009.01.056.
%
% Warning: This code is not optimized for speed.  Users may wish to run one
% part at a time.
%
% The Rice Wavelet Toolbox (rwt) is required on the MATLAB path
% (http://dsp.rice.edu/software/rice-wavelet-toolbox).
%
% Andrew Bolstad
% June 11, 2009

% The following adds ModEM, Subroutines, ModelData, rwt to the MATLAB path
addpath ModEM
addpath Subroutines
addpath ModelData
addpath rwt

load BrainData.mat vDL vDR fDL fDR nDL nDR  %vertices, faces, normals right/left

% Simulated Data Generation -----------------

% time courses
Fs=1000; %520.8;
tmax=249/Fs;
t=0:1/Fs:tmax;
timecourse1=exp(-50*t).*sin(100*t); % was -75*t
timecourse2=[zeros(1,floor(.2*520.8)),timecourse1(1:length(timecourse1)-floor(.2*520.8))];
timecourse3=[zeros(1,18),timecourse1(1:232)];
time=t;

% Find patches for example

%Patch in right auditory
D=sedgelen(fDR.white,vDR.white); % distances between all neighbors
v1=reach(D,12211);  % shortest paths to node 12211
p1=find(v1<.01);   % all vertices with path distances less than 10 mm
x1=zeros(12297,1);
x1(p1)=cos(150*v1(p1));  % Cosine shape within patch

%Patch in right somatosensory
v2=reach(D,9645);  
p2=find(v2<.01); 
x2=zeros(12297,1);
x2(p2)=cos(150*v2(p2));

%Patch in left auditory
D=sedgelen(fDL.white,vDL.white);  % Only needed if on a different hemi
v3=reach(D,1380); 
p3=find(v3<.01); 
x3=zeros(12217,1);
x3(p3)=cos(150*v3(p3));

% Apply timecourses to patches to get cortical signals

s=length(x1); t=length(x2); u=length(x3);
x=zeros(3*(s+t+u),1);
for c=1:s
    x(3*c-2:3*c)=x1(c)*nDR.white(c,:)';
end
for c=1:t
    x(3*s+3*c-2:3*s+3*c)=1.8*x2(c)*nDR.white(c,:)';
end
for c=1:u
    x(3*s+3*t+3*c-2:3*s+3*t+3*c)=x3(c)*nDL.white(c,:)';
end
xl=x(3*s+3*t+1:3*(s+t+u))*timecourse3;
xr=x(1:3*s)*timecourse1+x(3*s+1:3*(s+t))*timecourse2;
x=[xl;xr];
clear s t u xl xr *DL *DR D 

% Load leadfields

H=zeros(274,73542);
load BrainData Hl
for c=1:12217
    H(:,3*c-2:3*c)=squeeze(Hl(c,:,:));
end
clear Hl
load BrainData Hr
for c=12218:24514
    H(:,3*c-2:3*c)=squeeze(Hr(c-12217,:,:));
end
clear Hr

% Apply leadfields to cortical signals to get noise free measurements

Y_nf=H*x;

% Pad temporal length

Y_nf=[Y_nf,zeros(274,6)];

% Add Noise

SNR=-6; % dB
nTrials=60;

% White noise variance
sigma2=trace(Y_nf'*Y_nf)/(10^(SNR/10)*size(H,1)*size(Y_nf,2));

% Add noise scaled to get SNR = -6 dB after averaging 60 trials
Y=repmat(Y_nf,[1 1 nTrials])+sqrt(nTrials*sigma2)*randn([size(Y_nf),nTrials]);
Rwhiten=eye(size(Y,1)); % Covariance matrix of white noise


% Reconstruction section begins ----------------
Ym=mean(Y,3);

% Whiten here 

Yw=Rwhiten*Ym;
Hw=Rwhiten*H;

% Temp Bases construction
W=WaveBases(64,8); binsize=64;  % Wavebases calls Rice Wavelet Toolbox
C=W(1:32,:)'; clear W
nBases=size(C,2);
G=sparse(size(Yw,2),7*nBases); 
for c=1:7
    G(binsize/2*(c-1)+1:binsize/2*(c-1)+binsize,nBases*(c-1)+1:nBases*c)=C;
end
KG=nBases*ones(7,1);

% Load predefined patches

load LeftWhitePatches_20mm P
Pl=P;
load RightWhitePatches_20mm P
Pr=P;
clear P
nl=size(Pl,2); nr=size(Pr,2);
ml=max(Pl(:)); mr=max(Pr(:));
Wl=zeros(ml,nl); Wr=zeros(mr,nr);
W=zeros(ml+mr,nl+nr);
for c=1:nl
    Wl(setdiff(Pl(:,c),0),c)=1;
end
for c=1:nr
    Wr(setdiff(Pr(:,c),0),c)=1;
end
W(1:ml,1:nl)=Wl;
W(ml+1:ml+mr,nl+1:nl+nr)=Wr;
clear ml mr Pl Pr Wl Wr

% Compute patch bases (nb = 3 bases per patch)

nb=3;
[Uc Vc Patch_evals]=pSVD(Hw,W,nb);
[Vlr Kp]=makeV(Vc,W,Patch_evals);

iWt=sparse(diag(1./Patch_evals(:)));

% ESP reconstruction -----------------------

options.penalty=2;
[BlockAnswer options]=stsincsolver(Yw,Hw*Vlr*iWt,G,Kp,KG,options);

% Display Results --------------------------

% Figure 5
load BrainData v* f* n*
figure; BrainViewer(x(1:36651,30),fDL.white,vDL.white,nDL.white)
view([165,15])
C=colormap; C=[.7 .7 .7;C]; colormap(C)
caxis([0 10]), h=colorbar; delete(h) % Produces 'binary' effect of figure 5
title('Original Signal, t=30')
figure; BrainViewer(x(36652:73542,12),fDR.white,vDR.white,nDR.white)
colormap(C)
caxis([0 10]), h=colorbar; delete(h)
title('Original Signal, t=12')
figure; BrainViewer(x(36652:73542,116),fDR.white,vDR.white,nDR.white)
colormap(C)
caxis([0 10]), h=colorbar; delete(h)
title('Original Signal, t=116')

figure;
plot(1:250,timecourse1,'b',1:250,timecourse3,'g-.',1:250,timecourse2,'r:')
xlabel('time,ms')
legend('Right Auditory','Left Auditory','Motor','location','northeast')

figure; plot(Ym')
axis([1 250 -6e-5 8e-5])
xlabel('time,ms'), ylabel('field')

% Heuristic for determining a reasonable value for penalty weight lambda 
t=sum(BlockAnswer~=0);
t=sum(reshape(t,224,91));
endpt=rank(Hw*Vlr*iWt)*rank(full(G))/KG(1)/Kp(1);
t2=findlq2(t,endpt);

% The next line finds a "debiased" cortical signal estimate.  It can be very slow.
%Xhat=LargeLS2(Yw,Hw*Vlr,G,Kp,KG,BlockAnswer(:,(t2-1)*224+1:t2*224));

% The next line finds a cortical signal estimate without debiasing.
Xhat=Vlr*iWt*BlockAnswer(:,(t2-1)*224+1:t2*224)*G';

figure; BrainViewer(Xhat(1:36651,30),fDL.white,vDL.white,nDL.white)
view([165,15])
colormap(C)
h=colorbar; delete(h)
title('Original Signal, t=30')
figure; BrainViewer(Xhat(36652:73542,12),fDR.white,vDR.white,nDR.white)
colormap(C)
h=colorbar; delete(h)
title('Original Signal, t=12')
figure; BrainViewer(x(36652:73542,116),fDR.white,vDR.white,nDR.white)
colormap(C)
h=colorbar; delete(h)
title('Original Signal, t=116')
