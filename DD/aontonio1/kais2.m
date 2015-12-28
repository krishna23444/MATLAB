clc
clear all

m=.7;
alp=.1;
N=11;
del=.01;

n=(N-1)/2;

L=1;
for  o=1:4
    l=1;    
    n=n+2;

for i=-n:n
    h(n+i+1)=cos(i*pi)/i;
end
h(i+1)=0;
for alp=.1:.1:12
   
for i=-n:n
r(i+n+1)=I(alp*sqrt(1-(2*i/(N-1))^2))/I(alp);
end
y=abs(fft(r.*h,3140));

%%plot(y)
for i=1:1570
    d(i)=(pi/1570)*i;
end

for i=1:1570
    e(i)=abs(d(i)-y(i));
 end
% figure(2)
% plot(e)
L(l)=max(e(1:m*1570));
l=l+1;
end
figure(3)
semilogy(L)
hold on


min(L)
end

