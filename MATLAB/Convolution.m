clc
clear all
x = input('enter the sequence');
h = input('enter the response');
m=length(x);
n=length(h);
k=m+n-1;
y=zeros(1,k);
y(1) = x(1)*h(1);
for i=2:k
    for j=1:i
        if((i-j)>=0 && j<=m && (i-j+1)<=n)
            y(i) = y(i)+(x(j)*h(i-j+1));
        end
    end
end
disp('The convolution is '),

