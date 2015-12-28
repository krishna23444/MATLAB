clc;clear;close all
%% crop the image
imin=imread('D:\MATLAB 2010 Portable\bin\Attacks\L_0.2.jpg');
figure;
% imshow(imin);
% for cro=60
% P.param1=cro;
% P.param2=-9999;
% pp=CM_cropping(P,imin);
% figure
% imshow(pp);
% end
% close all;pause;
%% rotate the image
clear P pp 
for rot=90
P.param1=rot;
pp=CM_rotation(P,imin);
figure
imshow(pp);
end