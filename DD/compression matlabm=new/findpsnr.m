clc
clear all
close all
m=512;
n=512;
filename='D:\desktop\pendrive material\london.img';
 fp=fopen(filename,'r');
 a = fread(fp,[m,n],'uint8');
 imshow(a,[0,255])
% b=imread('C:\Users\dell\Desktop\hilly.jpg');
% 
% a=rgb2gray(b);
% a=double(a);
% imshow(a,[0,255])
% title('Original image')
figure

i=0.84
j=1;
c=[2.9 ];
encoded=blkproc(a,[8,8],'fracF2D',i,i);
for k=1:length(c) 
encoded (abs(encoded)<c(k)) = 0;
noofbytes = nnz(encoded);
decoded=(round(blkproc(encoded,[8,8],'fracF2D',-i,-i)));
CR=(((m*n)-noofbytes)/(m*n))*100
mse=abs(MSE(a,decoded))
psnr=10*log10((255^2)/mse)
% ps1=PSNR1(a,decoded)
% sprintf('the mean squared error is %4f.',... 
%     )
% 
 %psnr=10*log10(255^2/mean2((a-decoded)).^2);
% sprintf('With cutoff=95.5,the mean squared error is %4f.',...
%     MSE1(a,decoded))
%  sprintf('With cutoff=95.5, the psnr is %4f.',...
%      ps)

end
imshow (decoded,[0,255])
% title('decompressed image at 50% CR and 0.5 fractional order')
%c=uint32([c,j,noofbytes]) 
% j=j+1;
% if j==11
%     j=1;
% end
% end 