clc
clear all
a=imread('C:\Users\dell\Desktop\intersection2.gif');
s=size(a)
%a=rgb2gray(b);
a=double(a);
m=512;
n=512;
i=1


encoded=blkproc(a,[8,8],'fracF2D',i,i);

encoded(abs(encoded)<3)=0;

decoded=round(blkproc(encoded,[8,8],'fracF2D1',-i,-i));
noofbytes = nnz(encoded)
CR=(((m*n)-noofbytes)/(m*n))*100
ps=PSNR(decoded,a)

sprintf('With cutoff=95.5,the mean squared error is %4f.',MSE(decoded,a))
% 
 %psnr=10*log10(255^2/mean2((a-decoded)).^2);
% 
 sprintf('With cutoff=95.5, the psnr is %4f.',ps)