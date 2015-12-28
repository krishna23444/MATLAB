function divop = dcifftlkfn(x)
if (isprime(x)==1)
    x=[x zeros(1,1)]
else
    x=x;
end
r=max(factor(length(x)));
c=length(x)/r;
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
      k=twiddle2lkfn(ha);
      h(:,j)=k;
end
t=twiddle2lkfn(n2);
for i=1:r
    for j=1:c
        u(i,j)=t(i,j);
    end
end
g=h.*u;
g;
for i=1:r  
fa=g(i,:);
  ka=twiddle2iftlkfn(fa);
    f(i,:)=ka;   
end
for i=1:c
    for j=1:r
        z(v)=f(j,i);
        v=v+1;
    end
end
divop=z;
end