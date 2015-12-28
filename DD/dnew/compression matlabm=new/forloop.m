clc
clear all
m=512;
n=512;
% filename='C:\Users\dell\Desktop\london.img';
% fp=fopen(filename,'r');
% a=fread(fp,[m,n],'uint8');
% a=uint8(a);
a=imread('C:\Users\dell\Desktop\intersection2.gif');


whos

a=double(a);


a=imresize(a,1);

colormap('gray');
b=[20 30 40 50 60 ];
 
for i=1:length(b);
  
  

%since many figures will be produced by this script, we use meaningful labels.



%Implement the compression scheme

encoded=blkproc(a,[8,8],'fracF2D');

encoded(abs(encoded)<b(i))=0;

decoded=round(blkproc(encoded,[8,8],'fracF2D1'));

noofbytes=nnz(encoded)

% sprintf('at b is equal  %4f.',b(i))
% CR=((m*n-noofbytes)/(m*n))*100
% %Provide the error value to check against the expected value from the set.
% 
% sprintf('With cutoff=95.5,the mean squared error is %4f.',mean2((decoded-a).^2))
% 
% psnr=10*log10(255^2/mean2((decoded-a).^2));
% 
% 
% sprintf('With cutoff=95.5, the psnr is %4f.', psnr)
% 
% %pause
% 
% % figure;
% % set(gcf,'NumberTitle', 'off', 'Name', 'Decoded image');
% 
% imshow(decoded,[0 255]);
% % figure;
% 
% % set(gcf,'NumberTitle', 'off', 'Name', 'Encoded image');
% % 
% % imshow(encoded,[0 255]);


end 
