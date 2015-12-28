b=imread('C:\Users\dell\Desktop\products_stereo.jpg');
a=rgb2gray(b);
a=double(a)
m=256;
n=256;
d=[];
g=1;
e=[];
c=[0.1 0.2 0.3 0.4 0.5 0.6 0.7  0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1 ]  %% fractional order
f=[ 93 88.3 74.3 66 49.5 47.5 9.8 9.4 9.15 8.9 8.45 8.1 7.7 7.45 7.2 6.9 6.6 ]
for i=1:length(c)
    for k=g; 
encoded=blkproc(a,[8,8],'fracF2D',c(i),c(i));

encoded(abs(encoded)<f(k))=0;

decoded=round(blkproc(encoded,[8,8],'fracF2D1',-c(i),-c(i)));

noofbytes=nnz(encoded)

%Provide the error value to check against the expected value from the set.

sprintf('With cutoff=95.5,the mean squared error is %4f.',mean2((a-decoded).^2));
% 
 psnr=10*log10(255^2/mean2((a-decoded).^2));
% 
 sprintf('With cutoff=95.5, the psnr is %4f.', psnr)
CR=(((m*n)-noofbytes)/(m*n))*100
 d=[d,c(i),CR]

   
    end
    g=g+1;
end