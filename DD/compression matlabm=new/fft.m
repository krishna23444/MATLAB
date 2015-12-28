clc
clear all
m=256;
n=256;
% filename='C:\Users\dell\Desktop\london.img';
%  fp=fopen(filename,'r');
%  a = fread(fp,[m,n],'uint8');
b=imread('C:\Users\dell\Desktop\hilly.jpg');

a=rgb2gray(b);
a=double(a);

i=1
j=1;
c=[40 ];
encoded=blkproc(a,[8,8],'dct');
for k=1:length(c) 
encoded(abs(encoded)<c(k))=0;
noofbytes = nnz(encoded);
decoded=round(blkproc(encoded,[8,8],'dct'));
CR=(((m*n)-noofbytes)/(m*n))*100
ps=PSNR(a,decoded)
sprintf('With cutoff=95.5,the mean squared error is %4f.',...
    MSE(a,decoded))
% 
 %psnr=10*log10(255^2/mean2((a-decoded)).^2);

 sprintf('With cutoff=95.5, the psnr is %4f.',...
     ps)

end
