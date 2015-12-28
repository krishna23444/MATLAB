clear all
clc
close all
xlnc=[0.5 0.8 1.1];
% [V x]=ReadData3D('C:\3dcsi\HU1043_13_07_12\TSE_TRA_LH_RH_14_14_1.PAR');
% pic = struct('a','peacock');si=size(pic);
% pic = struct('a',{'dandeli','peacock','KNhair','rabbit'});si=size(pic);
mo=1;
%  pic=input('enter name of image','s');
% p=double(V(:,:,20));
p=double(imread(strcat('D:\MATLAB 2010 Portable\bin\DD\dnew\images\','hu1043lhrh','.jpg')));
% xln=input('V = ','s');
% xlnc=str2num(xln);
%% CONVEX DESIGN I
mm=4000; n = 3; lbd=.9; wpass = pi; wstop = pi; atten_level = -50;pt=lbd*mm;qq=1;
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
for v=xlnc
    
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

%% FREQ RESPONSE
a=([linspace(0,pi,mm)].^v).';
[H0 xc]=freqz(b0,1,mm);
xx0=abs(H0);
fx0=(abs(a(1:pt)-xx0(1:pt))).^2;
convexmse(qq)=(((fx0(1)+fx0(end))/2)+(sum(fx0(2:end-1))))/mm

% figure(mo);mo=mo+1;
% plot(xx0,'k');
% hold on
% plot(xx1,'r');
% plot(xx2);
% plot(a);
%%

siz=size(p);

for k=1:siz(1)
x0(k,:,1)=filtfilt(b0,1,p(k,:,1));x0(k,:,2)=filtfilt(b0,1,p(k,:,2));x0(k,:,3)=filtfilt(b0,1,p(k,:,3));
end

for k=1:siz(2)
y0(:,k,1)=filtfilt(b0,1,p(:,k,1));y0(:,k,2)=filtfilt(b0,1,p(:,k,2));y0(:,k,3)=filtfilt(b0,1,p(:,k,3));
end
gh0(:,:,:,1)=y0+p+x0;
figure(1)
subplot(2,2,qq+1)
imshow(uint8(gh0(:,:,:,1)));

qq=qq+1;
end
subplot(2,2,1)
imshow(uint8(p));


% set(1:mo-1,'color','w');
% aaa='D:\MATLAB 2010 Portable\bin\DD\dnew\imagesfordd\paperpicsmse';
% bbb='.tiff';
% for k=1:mo-1
% number=[xlnc k];
% writeFig300dpi(k,strcat(aaa,num2str(number),bbb))
% end
% close all