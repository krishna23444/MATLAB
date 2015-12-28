close all

clc
cr=input('enter the compression  ratio');
m=512;
n=512;
% filename='C:\Users\dell\Desktop\london.img';
% fp=fopen(filename,'r');
% a=fread(fp,[m,n],'uint8');
% % a=u*int8(a);
nob=int32((m*n)-(cr*(m*n)/100))
%a=imread('C:\Users\dell\Desktop\intersection2.gif');
%a=rgb2gray(b);


% a=double(a);
% 
% 
% a=imresize(a,1);
% 
% colormap('gray');
% 
% %since many figures will be produced by this script, we use meaningful labels.
% 
% set(gcf,'NumberTitle', 'off', 'Name', 'satellite image');
% 
% %imshow(a,[0 255]);
% 
% %Implement the compression scheme
% 
% % encoded=blkproc(a,[8,8],'fracF2D')
% % 
% % encoded(abs(encoded)<7.47)=0
% % 
% % decoded=round(blkproc(encoded,[8,8],'fracF2D1'));
% encoded=blkproc(a,[8,8],'fracF2D');
% % % % 
% % % % %Now we begin to collect data for the graph.
% % % % 
% c=[];
% i=0;
% for cutoff=7.5:0.001:8
%     
% encoded(abs(encoded)<cutoff)=0;
% 
% %decoded=round(blkproc(encoded,[8,8],'fracF2D1'));
% % %We will simply append to the vectors each time through this loop.
% 
% c=[c,cutoff];
% 
% noofbytes=nnz(encoded)
% i=i+1
% if noofbytes==nob
%     display(c)
% end 
% end
