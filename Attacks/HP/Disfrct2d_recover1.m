%Name:		Chris Shoemaker
%Course:	EER-280 - Digital Watermarking
%Project: 	Block DCT Based method, using comparision between mid-band coeffcients
%           Watermark Recovery

clear all;
clc;

% save start time
start_time=cputime;

blocksize=4;    % set the size of the block in cover to be used for each bit in watermark

% read in the watermarked object
file_name='Disfrct_watermarked_b1.bmp';
% file_name='dsfrct_watermarked.bmp'
% file_name='dfrct_watermarked_b.bmp';
% file_name='dsfrct_watermarked.bmp';
% file_name='Disfrct_watermarked_L.bmp';
watermarked_image=double(imread(file_name));

% determine size of watermarked image
Mw=size(watermarked_image,1);	        %Height
Nw=size(watermarked_image,2);	        %Width

% determine maximum message size based on cover object, and blocksize
max_message=Mw*Nw/(blocksize^2);

% read in original watermark
file_name='copyright.bmp';
orig_watermark=double(imread(file_name));

% determine size of original watermark
Mo=size(orig_watermark,1)	%Height
No=size(orig_watermark,2)	%Width

% process the image in blocks
x=1
y=1
for (kk = 1:max_message)
    
    % display progress to the console
    for a=0:.1:1;
    if (mod(kk,max_message) == 0)
        kk;
    end    
    
    % generate a new sequence and calulate correlation to baseline
%     pn_sequence=round(2*(rand(8,8)-0.5));
%     pn_base_sequence=round(2*(rand(8,8)-0.5));
%     correlation(kk)=corr2(pn_sequence,pn_base_sequence);
end

% plot the correlation for each sequence
% figure(1)
% set(1,'color','white')
% plot(correlation(1:kk))


    % transform block using DCT
    dct_block=disfrct2d(watermarked_image(y:y+blocksize-1,x:x+blocksize-1),.4,0);

    % if dct_block(5,2) > dct_block(4,3) then message(kk)=0
    % otherwise message(kk)=1
    if dct_block(5,2) > dct_block(4,3)
        message_vector(kk)=0;
    else
        message_vector(kk)=1;
    end
 
    % move on to next block. At and of row move to next row
    if (x+blocksize) > Nw
        x=1;
        y=y+blocksize
    else
        x=x+blocksize
    end
end

% reshape the embeded message
message=reshape(message_vector(1:Mo*No),Mo,No);

% display processing time
elapsed_time=cputime-start_time,

% display recovered message
figure(2)
imshow(message,[])
title('Recovered Message')
