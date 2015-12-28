clc
clear all

x=input('enter the sequence');
N=length(x);
%%
f=factor(N);
M=f(length(N));
L=sum(f)-M;
%%
p=1;
for i=1:M
    for j=1:L
        x1(i,j)=x(p);
        p=p+1;
    end
end
%%
for i=1:L
    x2(:,i)=WN(M)*x1(:,i);
end
%%
for i=1:M
    for j=1:L
        x3(i,j)=twid((i-1),(j-1),N).*x2(i,j);
    end
end
%%
for i=1:M
    x4(i,:)=x3(i,:)*WN(L);
end
%%
p=1;
for i=1:L
    for j=1:M
        x5(p)=x4(j,i);
        p=p+1;
    end
end
x5


    