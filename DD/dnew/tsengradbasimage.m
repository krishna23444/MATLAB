clc
clear all
close all

% b=load('D:\MATLAB 2010 Portable\bin\DD\dnew\tsengradbasimage15.mat');
b(2,:)=[-0.1445    0.6960    0.1411   -0.8527    0.1604];%v=1h=0.1
b(3,:)=[-0.2236 1.2273 -1.0789 -0.3419 0.3792];%v=1.5h=.1
 b(1,:)=[-0.1070    0.4145    0.5533   -0.3070   -0.2746];%v=.5h=.1
%  b(2,:)=[-0.2347    1.3356   -1.3404   -0.0837    0.2654];%v=1.5h=.03
%  b(1,:)=[-0.0540    0.2573    0.8419   -0.6679    0.0213];%v=.5h=.03
%  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\barbara.jpg'));
%  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\compsens\missingpix\obama1.jpg'));
%  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\dnew\toy.jpg'));
p=double(imread('D:\MATLAB 2010 Portable\bin\DD\dnew\images\KNhair.bmp'));
n=size(p);
figure(1)
imshow(uint8(p));title('original image');
for mm=1:3
for k=1:n(1)
x1(k,:,1)=filtfilt(b(mm,:),1,p(k,:,1));x1(k,:,2)=filtfilt(b(mm,:),1,p(k,:,2));x1(k,:,3)=filtfilt(b(mm,:),1,p(k,:,3));
end

for k=1:n(2)
y1(:,k,1)=filtfilt(b(mm,:),1,p(:,k,1));y1(:,k,2)=filtfilt(b(mm,:),1,p(:,k,2));y1(:,k,3)=filtfilt(b(mm,:),1,p(:,k,3));
end
gh(:,:,:,mm)=y1+p+x1;
figure(mm+1)
imshow(uint8(gh(:,:,:,mm)));title(strcat('v  =   ',num2str(mm*.5)))
end