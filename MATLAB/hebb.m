clc
clear all
n=input('enter no. of vectors');
w1=input('enter starting vector');
for i=1:n
    x=input('enter input vector');
    net =sum(w1.*x);
    if net>0
        sgn=1;
    else
        sgn=-1
    end
    w=w1+(sgn*x)
    disp('updated weights are')
w
end
        