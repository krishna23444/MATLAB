clc
clear all
[x1, Fs, nbits]  = wavread('D:\MATLAB 2010 Portable\bin\MATLAB\neewww\windows shutdown');

x=x1(1:50000,:);
b=1*10^-4;
a=-1*10^-4;
bit=3;
R=((b-a)/2^bit);
a1(1)=a;
a1(2^bit+1)=b;
for i=2:2^bit
    a1(i)=a1(i-1)+R;
end

T=dec2bin(0:2^bit-1);

for i=1:length(x)
    y1(i,:)=T(sum(x(i)>a1)-1,:);
end
y2=y1.';
y=y2(:).';


