function y=filt_imag(p,b)
siz=size(p);
x0=zeros(siz(1),siz(2));
y0=zeros(siz(1),siz(2));
for k=1:siz(1)
x0(k,:,1)=filtfilt(b,1,p(k,:,1));x0(k,:,2)=filtfilt(b,1,p(k,:,2));x0(k,:,3)=filtfilt(b,1,p(k,:,3));
end

for k=1:siz(2)
y0(:,k,1)=filtfilt(b,1,p(:,k,1));y0(:,k,2)=filtfilt(b,1,p(:,k,2));y0(:,k,3)=filtfilt(b,1,p(:,k,3));
end
y=y0+p+x0;