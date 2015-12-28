clc
clear all

format long G
N=10;
nn=5;
to=10;
v=2.5;
for k=0:N
    for p=-nn:nn
    
    A(p+1+nn,k+1)=exp(1i*2*pi*p*(N+1-k));
    
    
    b(p+1+nn)=((1i*2*pi*p)^v)*exp(1i*2*pi*(p-to));
    if p==-1 && k==3
        A
        b
    end
    
    end
end
h=inv(A)*b.';
[f,d]=freqz(h,1,linspace(0,pi,3141));
% a=[linspace(0,pi,3141)].^v;
% a=a./(10^6);
% plot((1:3141)/1000,a);
% hold on
figure(2)
plot((1:3141)/1000,abs(f));
grid on


