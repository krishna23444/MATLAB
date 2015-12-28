clc
clear all
close all
format long
m=0.64
p=.8
%%
A=[-.0003334007 .004885061 -.02182403 .06596553 -.1623368 .3661750 -.9261358];
for i=1:7
    A(i+8)=-A(8-i);
end
A(8)=0;
J=abs(fft(A,6280))
 for i=1:3140
        d(i)=(pi/3140)*i;
 end
 q=1;
 for i=ceil(m*p*3140):ceil(m*3140)
        e(q)=abs(J(i)-d(i));
        q=q+1;
 end
 




