function divop = dcifftlkfn(x)
n=length(x);

r=max(factor(n));
c=n/r;
l=1;
v=1;
for i=1:r
    for j=1:c
        y(i,j)=x(l);
        l=l+1;
    end
end
y;
for j=1:c
      ha=y(:,j);
      k=twiddle2lkfn(r);
      h(:,j)=(k*ha)/r;
end
t=twiddle2lkfn(n);
for i=1:r
    for j=1:c
        u(i,j)=t(i,j);
    end
end
g=h.*u;
g;
for i=1:r  
fa=g(i,:);
  ka=twiddle2lkfn(c);
    f(i,:)=(fa*ka)/c;   
end
for i=1:c
    for j=1:r
        z(v)=f(j,i);
        v=v+1;
    end
end
divop=z;
end