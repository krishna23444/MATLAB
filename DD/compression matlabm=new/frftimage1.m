
% M`ATLAB PROGRAM FOR IMAGE COMPRESSION USING DISCRETE FOURIER TRANSFORM(DFT)

%this program used for compression of barbara image and find mean squared
%error and psnr for various cutoff and plot it.

clear all

close all

clc

m=512;
n=512;
%  filename='C:\Users\dell\Desktop\london.img';
%  fp=fopen(filename,'r');
%  a = fread(fp,[m,n],'uint8');

b=imread('D:\MATLAB 2010 Portable\bin\DD\dnew\images\KNhair.bmp');
a=rgb2gray(b);

whos

a=double(a);


a=imresize(a,1);




%since many figures will be produced by this script, we use meaningful labels.

%set(gcf,'NumberTitle', 'off', 'Name', 'lena-original image');

%imshow(a,[0 255

%Implement the compression scheme
d=[];
psnr1=[];
mse1=[];
c=[ 0.98 1  ]  %% fractional order
for i=1:length(c)
    for k=1:1:4
encoded=blkproc(a,[8,8],'fracF2D',c(i),c(i));

encoded(abs(encoded)<k)=0;

decoded=round(blkproc(encoded,[8,8],'fracF2D',-c(i),-c(i)));

noofbytes=nnz(encoded)

%Provide the error value to check against the expected value from the set.
mse=mean2((a-decoded).^2);

sprintf('With cutoff=95.5,the mean squared error is %4f.'....
    ,mse);
% 
 psnr=10*log10(255^2/mean2((a-decoded).^2));
% 
 sprintf('With cutoff=95.5, the psnr is %4f.',....
     psnr);
CR=((m*n-noofbytes)/(m*n))*100
 d=[d,i,k,CR]
 psnr1=[psnr1,psnr]
 mse1=[mse1,mse]
 m=real(mse1)
    end
   
end

%pause

%figure;

%set(gcf,'NumberTitle', 'off', 'Name', 'Decoded image');

%imshow(decoded,[0 255]);

%provide the difference between original image and reconstructed image for

%cutoff<100
% 
% encoded=blkproc(a,[8,8],'fracF2D');
% 
% encoded(abs(encoded)<100)=0;
% 
% decoded=round(blkproc(encoded,[8,8],'fracF2D1'));
% noofbytes=nnz(encoded);
% 
% sprintf('With cutoff=100, the mean squared error is %4f.',... 
% mean2((a-decoded).^2))
% 
% psnr=10*log10(225^2/mean2((a-decoded).^2));
% 
% sprintf('With cutoff=100, the psnr is %.4f',... 
%     psnr)
% 
% diff=a-decoded;
% 
% %pause
% 
% %figure;
% 
% %set(gcf,'NumberTitle', 'off', 'Name', 'Difference image');
% 
% imshow(diff,[0 255]);
% % 
% % % Initialize the vectors that will store the data for the graph.
% % 
% c=[];
% 
% x=[];
% 
% y=[];
% 
% z=[];
% 
% % % %This is not repetition from before; since we want to start with a threshold
% % % 
% % % %of zero, we must re-encode the image since we already dropped several terms
% % % 
% % % %to zeros earlier in the problem. Then, since we will be steadily increasing
% % % 
% % % %the threshold, we need not do this conversion any more because we will be
% % % 
% % % %simply zeroing-out more elements with each iteration through the for loop
% % % 
% % % %(there is no reason to recover all the original elements and start from
% % % 
% % % %each line through the loop; we can progressively drop more and more
% % % 
% % % %data).
% % % 
% encoded=blkproc(a,[8,8],'fracF2D');
% % % 
% % % %Now we begin to collect data for the graph.
% % % 
% for cutoff=10:40:100,
% 
% encoded(abs(encoded)<cutoff)=0;
% 
% decoded=round(blkproc(encoded,[8,8],'fracF2D1'));
% 
% % %We will simply append to the vectors each time through this loop.
% 
% c=[c,cutoff];
% 
% x=[x,nnz(encoded)];
% 
% CR=(((256*256)-x)/(256*256))*100;
% 
% y=[y,mean2((a-decoded).^2)];
% 
% psnr=10*log10(255^2/mean2((a-decoded).^2));
% z=[z,psnr];
% 
% sprintf('With cutoff=c, the mean squared error is %4f.',... 
% mean2((a-decoded).^2));
% 
% psnr=10*log10(225^2/mean2((a-decoded).^2));
% 
% sprintf('With cutoff=c, the psnr is %.4f',... 
%     psnr);
% 
% %The next three lines can be commented out if they are not desired. They
% 
% %will produce a new window, label it, and print a representation of the 
% 
% %newly decoded image for each cutoff threshold. This is for comparison
% 
% %with the original image to answer the question in the set that asks at
% 
% %which point the difference between the original image and the compressed
% 
% %image becomes perceptible to the human eye.
% %pause
% 
% % figure;
% % 
% % set(gcf,'NumberTitle','off', 'Name', sprintf('cutoff=%d', cutoff));
% 
% % imshow(decoded,[0 255]);
% 
% end
% 
% %Now, plot the graph with a smooth curve and boxes around all the actual data
% 
% %points.
% 
% %pause
% figure;
% set(gcf,'NumberTitle', 'off', 'Name', 'Graph1 for lena image');
% 
% plot(x,y,'s-')
% 
% title('Comparison of File Size and Image Error');
% 
% xlabel('Non-zero matrix values (number of bytes to store)');
% 
% ylabel('Mean squared error');
% 
% grid;
% 
% %pause
% 
% figure;
% 
% set(gcf,'NumberTitle', 'off', 'Name', 'Graph2 for lena image');
% 
% plot(x,z, 's-')
% 
% title('PSNR vs. no. of bytes to store');
% 
% xlabel('Non-zero matrix values (number of bytes to store)');
% 
% ylabel('psnr');
% 
% grid;
% 


