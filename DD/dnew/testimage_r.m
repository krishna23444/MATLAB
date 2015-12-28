clear all
clc
close all
pic = struct('a',{'dandeli'});si=size(pic);
nnn=1;

for cb=1:si(2)
clear x0 y0 x1 y1 x2 y2 gh0 gh1 gh2     
p=double(imread(strcat('D:\MATLAB 2010 Portable\bin\DD\dnew\images\',pic(cb).a,'.bmp')));
%% CONVEX DESIGN I
mm=4000; n = 3; lbd=.9; wpass = pi; wstop = pi; atten_level = -50;pt=lbd*mm;
N = 30*n+1;                           
w = linspace(0,pi,N);
% A = [ones(N,1) 2*cos(kron(w',[1:n-1]))]; 
 A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% A=2*[sin(kron(w',[1:n]))]%type III
% passband 0 <= w <= w_pass
ind1 = find((0.1 <= w) & (w <= wpass));   % 
Ap  = A(ind1,:);
ind2 = find((wstop <= w) & (w <= pi));  % stopband
Us  = 10^(atten_level/20)*ones(length(ind2),1);
As  = A(ind2,:);
for v=[0.8]
    
    clear h1 h delta
    
%% CONVEX DESIGN II
cvx_begin
 variable h(n,1);
    minimize( max(abs( Ap*h -(w(ind1).').^v)))% <= delta
cvx_end
% disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  b0 = [-flipud(h);h];
 end
 %% RADIAL BASIS DESIGN

sig=2.3;N=4;I=2;L=100;ss=0;h=.1; 

for m=0:N
    for k=0:L
    ss=ss+((-1)^k)*gamma(v+1)*gee(m,I+k*h,N,sig)/((h^v)*gamma(k+1)*gamma(v-k+1));
    end
    b2(m+1)=ss;
    ss=0;
end
b2(1)=b2(1)-sum(b2);

%%
dimsz=size(p);
gh0(:,:,:,nnn)=filt_imag(p,b0);
% figure
% imshow(uint8(gh0(:,:,:,1)));title(strcat('convex mse  ',num2str(v)));

gh2(:,:,:,nnn)=filt_imag(p,b2);
% figure
% imshow(uint8(gh2(:,:,:,1)));title(strcat('radial basis  ',num2str(v)));



%   disp=[convexdirect.' convexmse.' radbas.']
 
% set(1:mo-1,'color','w');
% aaa='D:\MATLAB 2010 Portable\bin\DD\dnew\imagesfordd\paperpics';
% bbb='.tiff';
% for k=1:mo-1
% number=[xlnc k];
% writeFig300dpi(k,strcat(aaa,num2str(number),bbb))
% end
%%
clc
for kkk=1:3
    repp=gh0(:,:,kkk,nnn);
totmean=sum(sum(repp));
totdiff=(repp-totmean).^2;
totsum=sum(totdiff(:));
nele=(dimsz(1)*dimsz(2))-1;
totvar0(kkk,nnn)=totsum/nele;

imgMean=0;
for i=1:dimsz(1)
for j=1:dimsz(2)
imgMean = imgMean + double(repp(i,j));
end
end
% average
imgMean = imgMean / (dimsz(1)*dimsz(2));

imgVar = 0.0;
for i=1:dimsz(1)
for j=1:dimsz(2)
imgVar = imgVar + (double(repp(i,j)) - imgMean)^2;
end
end
imgVar0(kkk,nnn) = imgVar / (dimsz(1)*dimsz(2));

imgVar01(kkk,nnn) = (double(repp(:)) - imgMean)' * (double(repp(:)) - imgMean) / (dimsz(1)*dimsz(2));

ent0(kkk,nnn)=img_entrp(uint8(repp));

res0(kkk,nnn)=avggdt(repp);
end

for kkk=1:3
% res_g1(kkk,cb)=avggdt(gh1(:,:,kkk));
end

for kkk=1:3
    rep=gh2(:,:,kkk,nnn);
totmean=sum(sum(rep));
totdiff=(rep-totmean).^2;
totsum=sum(totdiff(:));
nele=(dimsz(1)*dimsz(2))-1;
totvar2(kkk,nnn)=totsum/nele;

imgMean=0;
for i=1:dimsz(1)
for j=1:dimsz(2)
imgMean = imgMean + double(rep(i,j));
end
end
% average
imgMean = imgMean / (dimsz(1)*dimsz(2));

imgVar = 0.0;
for i=1:dimsz(1)
for j=1:dimsz(2)
imgVar = imgVar + (double(rep(i,j)) - imgMean)^2;
end
end
imgVar2(kkk,nnn) = imgVar / (dimsz(1)*dimsz(2));

imgVar21(kkk,nnn) = (double(rep(:)) - imgMean)' * (double(rep(:)) - imgMean) / (dimsz(1)*dimsz(2));


ent2(kkk,nnn)=img_entrp(uint8(rep));

res2(kkk,nnn)=avggdt(rep);
end

% sev_0(nnn)=wentropy(gh0,'shannon')
% % sev_1(cb)=wentropy(gh1,'shannon')
% sev_2(nnn)=wentropy(gh2,'shannon')
nnn=nnn+1
end
end
close all