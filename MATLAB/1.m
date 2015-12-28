clc
clear all
x=input('enter the matrix')
y=input('enter the second matrix')
for k=1:3
    x1=x
    x1(:,k)=y
    d=x1
    z(k)=det(d)/det(x)
end
display(z)