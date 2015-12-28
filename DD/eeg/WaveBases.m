function W = WaveBases(s,fl)
%
%

% This is where Rice Wavelet Toolbox is used
% addpath I:\MEG_EEG\PatchL1Linf\WaveBases\rwt

%[lo_d hi_d]=wfilters('db4','d');
h=daubcqf(fl,'min');

N=log2(s);

W=zeros(s);
temp=zeros(s,1);

for c=1:s
    x=[zeros(c-1,1); 1; zeros(s-c,1)];
    W(:,c)=mdwt(x,h,N);

    
%     ca=x;
%     for d=1:N
%         [ca cd]=dwt(ca,lo_d,hi_d); size(ca),size(cd)
%         temp(2^(N-d)+1:2^(N-d+1))=cd;
%     end
%     temp(1)=ca;
%     W(:,c)=temp;
end

% Reorder
ord=zeros(s,1); ord(1:2)=[1;2];
for c=N:-1:2
    [y i]=max(abs(W(2^(c-1)+1:2^c,:)'));
    [y i]=sort(i);
    i=i+2^(c-1);
    W(2^(c-1)+1:2^c,:)=W(i,:);
    ord(2^(c-1)+1:2^c)=i;
end