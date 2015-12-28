clear all
clc
close all
% xlnc=[0.5 1.1];
xlnc=[0.4]
pic = struct('a',{'dandeli','peacock','KNhair','rabbit'});si=size(pic);
% pic = struct('a',{'Untitled'});si=size(pic);
mo=1;
%  pic=input('enter name of image','s');
for cb=1:si(2)
clear x0 y0 x1 y1 x2 y2 gh0 gh1 gh2     
p=double(imread(strcat('D:\MATLAB 2010 Portable\bin\DD\dnew\images\',pic(cb).a,'.bmp')));
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
    cvx_begin
  variable delta
  variable h1(n,1);

  minimize( delta )
  subject to
    % passband bounds
    Ap*h1 <=((w(ind1).').^v+ delta);
    Ap*h1 >= [zeros(1,18) ((w(ind1(19:length(ind1)))).^v)-delta].';

cvx_end

% check if problem was successfully solved
% disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  % construct the full impulse response
  b1 = [-flipud(h1);h1];
end
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
a=([linspace(0,pi,mm)].^v).';
[H2,ome]=freqz(b2,1,mm);
xx2=abs(H2);
fx2=(abs(a(1:pt)-xx2(1:pt))).^2;
radbas(qq)=(((fx2(1)+fx2(end))/2)+(sum(fx2(2:end-1))))/mm

%% FREQ RESPONSE

[H1 xc]=freqz(b1,1,mm);
xx1=abs(H1);
fx1=(abs(a(1:pt)-xx1(1:pt))).^2;
convexdirect(qq)=(((fx1(1)+fx1(end))/2)+(sum(fx1(2:end-1))))/mm

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
x1(k,:,1)=filtfilt(b1,1,p(k,:,1));x1(k,:,2)=filtfilt(b1,1,p(k,:,2));x1(k,:,3)=filtfilt(b1,1,p(k,:,3));
end

for k=1:siz(2)
y1(:,k,1)=filtfilt(b1,1,p(:,k,1));y1(:,k,2)=filtfilt(b1,1,p(:,k,2));y1(:,k,3)=filtfilt(b1,1,p(:,k,3));
end
gh1(:,:,:,1)=y1+p+x1;
figure
imshow(uint8(gh1(:,:,:,1)));title(strcat('convex direct ',num2str(v)));

for k=1:siz(1)
x0(k,:,1)=filtfilt(b0,1,p(k,:,1));x0(k,:,2)=filtfilt(b0,1,p(k,:,2));x0(k,:,3)=filtfilt(b0,1,p(k,:,3));
end

for k=1:siz(2)
y0(:,k,1)=filtfilt(b0,1,p(:,k,1));y0(:,k,2)=filtfilt(b0,1,p(:,k,2));y0(:,k,3)=filtfilt(b0,1,p(:,k,3));
end
gh0(:,:,:,1)=y0+p+x0;
figure
imshow(uint8(gh0(:,:,:,1)));title(strcat('convex mse  ',num2str(v)));

for k=1:siz(1)
x2(k,:,1)=filtfilt(b2,1,p(k,:,1));x2(k,:,2)=filtfilt(b2,1,p(k,:,2));x2(k,:,3)=filtfilt(b2,1,p(k,:,3));
end

for k=1:siz(2)
y2(:,k,1)=filtfilt(b2,1,p(:,k,1));y2(:,k,2)=filtfilt(b2,1,p(:,k,2));y2(:,k,3)=filtfilt(b2,1,p(:,k,3));
end

gh2(:,:,:,1)=y2+p+x2;
figure
imshow(uint8(gh2(:,:,:,1)));title(strcat('radial basis  ',num2str(v)));
qq=qq+1;
end
figure(mo);mo=mo+1;
imshow(uint8(p));title('original image');
disp=[convexdirect.' convexmse.' radbas.']
 end
% set(1:mo-1,'color','w');
% aaa='D:\MATLAB 2010 Portable\bin\DD\dnew\imagesfordd\paperpics';
% bbb='.tiff';
% for k=1:mo-1
% number=[xlnc k];
% writeFig300dpi(k,strcat(aaa,num2str(number),bbb))
% end
close all
clc
for kkk=1:3
res_g0(kkk)=avggdt(gh0(:,:,kkk));
end

for kkk=1:3
res_g1(kkk)=avggdt(gh1(:,:,kkk));
end

for kkk=1:3
res_g2(kkk)=avggdt(gh2(:,:,kkk));
end