clear all
clc
x=input('enter the input sequence = ');
n=length(x);
n1=n;
nf=ceil(log2(n));
while (nf ~= (log2(n1)))
       n1=n1+1;
end
x=[x zeros(1,(n1-n))];
n2=length(x);
m=max(factor(n2));
p=n2/m;
r=m;
c=p;
l=1;
v=1;
for i=1:r
    for j=1:c
        y(i,j)=x(l);
        l=l+1;
    end
end
y
for j=1:c
      ha=y(:,j);
      k=radix2lkfn(ha);
      h(:,j)=k;
end
t=twiddlelkfn(n2); 
for i=1:r
    for j=1:c
        u(i,j)=t(i,j);
    end
end
g=h.*u;
for i=1:r 
fa=g(i,:);
  ka=radix2lkfn(fa);
    f(i,:)=ka;   
   end
for i=1:c
    for j=1:r
        z(v)=f(j,i);
        v=v+1;
    end
end
z  