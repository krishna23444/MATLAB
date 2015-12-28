clc
clear all
a=imread('D:\MATLAB 2010 Portable\bin\DD\lenaoriginal.jpg');
s=size(a)
%a=rgb2gray(b);
a=double(a);
m=256;
n=256;
i=0.1
j=1;
c=[];

encoded=blkproc(a,[8,8],'fracF2D',i,i);
for k=10:0.1:60
encoded(abs(encoded)<k)=0;

%decoded=round(blkproc(encoded,[8,8],'fracF2D1',-i,-i));
noofbytes = nnz(encoded)
c=uint32([c,j,noofbytes]) 
j=j+1;
if j==11
    j=1;
end 
end 

%Provide the error value to check against the expected value from the set.
%y=mean2(abs((a-decoded)).^2)
% j=PSNR(decoded,a)

% sprintf('With cutoff=95.5,the mean squared error is %4f.',MSE(decoded,a))
% % 
%  %psnr=10*log10(255^2/mean2((a-decoded)).^2);
% % 
%  sprintf('With cutoff=95.5, the psnr is %4f.',j)
% CR=(((m*n)-noofbytes)/(m*n))*100