clc
clear all
close all

n = 3;N = 30*n;w = linspace(0,pi,N);wpass=pi;wstop=pi;
%  A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines
%  A=[ones(N,1) exp(1i*kron(w',1:n))];
  A=2*[sin(kron(w',[0.5:1:(2*n-1)/2]))];%type IV
% A=2*[sin(kron(w',[1:n]))]%type III
ind1 = find((0 <= w) & (w <= wpass));   % passband
Ap  = A(ind1,:);
l=2;
% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind2 = find((wstop <= w) & (w <= pi));  % stopband
As  = A(ind2,:);
% passband 0 <= w <= w_pass
for v=[0.5 1 ]
    
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
if v==1
 h=[0.3116   -0.2731   -0.6846    0.6846    0.2731   -0.3116]
end
% [H cc]=freqz(h,1,1000)
% figure(1)
% plot(abs(H),'k','LineWidth',1.7)
% %  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\compsens\missingpix\obama1.jpg'));
%  p=double(imread('D:\MATLAB 2010 Portable\bin\DD\dnew\toy.jpg'));
 p=double(imread('D:\MATLAB 2010 Portable\bin\DD\dnew\images\KNhair.bmp'));
 siz=size(p);
% figure(2)
% imshow(uint8(p))
for k=1:siz(1)
    x1(k,:,1)=filtfilt(h,1,p(k,:,1));x1(k,:,2)=filtfilt(h,1,p(k,:,2));x1(k,:,3)=filtfilt(h,1,p(k,:,3));
end
for k=1:siz(2)
    y1(:,k,1)=filtfilt(h,1,p(:,k,1));y1(:,k,2)=filtfilt(h,1,p(:,k,2));y1(:,k,3)=filtfilt(h,1,p(:,k,3));
end
gh(:,:,:,l-1)=y1+p+x1;
figure(l)
imshow(uint8(gh(:,:,:,l-1)))
l=l+1;
end
figure(1)
imshow(uint8(p))