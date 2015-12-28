clc
clear all
a=-2;
b=2;
bit=4;
x=[-1.7 -1.2 -.8 -.3 1.7 1.2 .8 .3];

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
    
    