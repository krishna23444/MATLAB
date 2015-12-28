clc
clear all
m=256;
n=256;
% filename='D:\desktop\pendrive material\london.img';
%  fp=fopen(filename,'r');
%  a = fread(fp,[m,n],'uint8');
b=imread('C:\Users\dell\Desktop\hilly.jpg');
% s=size(a)
a=rgb2gray(b);
a=double(a);

j=1;
c=[];
for i=1

encoded=blkproc(a,[8,8],'fracF2D',i,i);
for k=11.001:0.001:12
    
    
encoded(abs(encoded)<k)=0;

%decoded=round(blkproc(encoded,[8,8],'fracF2D1',-i,-i));
noofbytes = nnz(encoded);
c=([c,j,uint32(noofbytes)]) ;
j=j+1;
if j==1001
    j=1;
end
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