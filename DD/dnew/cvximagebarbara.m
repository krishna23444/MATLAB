clc
clear all
% close all
n = 3;N = 30*n;
v=0.5;
w = linspace(0,pi,N);wpass=pi;wstop=pi;
%  A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines
%  A=[ones(N,1) exp(1i*kron(w',1:n))];
   A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
%  A=2*[sin(kron(w',[1:n]))]%type III
ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);

% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));  % stopband
As  = A(ind2,:);
% passband 0 <= w <= w_pass
cvx_begin
 variable h(n,1);
    minimize( max(abs( Ap*h -(w(ind1).').^v)))% <= delta
cvx_end
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  h = [-flipud(h);h];
end
[H cc]=freqz(h,1,1000);
%  figure(1)
%  plot(abs(H),'k','LineWidth',1.7)
%  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\barbara.jpg'));
% mo=1;
% for lk=1:5
%     for kl=1:13
%         if kl>=10
%             aaa=strcat('1.',num2str(lk),'.',num2str(kl),'.tiff')
%         else
% aaa=strcat('1.',num2str(lk),'.0',num2str(kl),'.tiff')
%         end
        
% p=double(imread(strcat('D:\MATLAB 2010 Portable\bin\DD\imagesdatabase\textures\',aaa)));
 p=double(imread('D:\MATLAB 2010 Portable\bin\DD\dnew\images\misc4.2.03.tiff'));
% filename='D:\MATLAB 2010 Portable\bin\DD\dnew\london.img';
% mk=512;
% nk=mk;
%  fp=fopen(filename,'r');
%  p = fread(fp,[mk,nk],'uint8');
n=size(p);
%  figure(2)
%  imshow(uint8(p))
for k=1:n(1)
    x1(k,:)=filtfilt(h,1,p(k,:));
end

for k=1:n(2)
    y1(:,k)=filtfilt(h,1,p(:,k));
end
gh=y1+p+x1;
figure(1)
imshow(uint8(gh))
% mo=mo+1;
% clear x1 y1
%     end
% end
