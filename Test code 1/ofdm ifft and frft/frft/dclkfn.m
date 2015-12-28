function divop = dclkfn(x)
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

for j=1:c
      ha=y(:,j);
      k=twiddlelkfn(r);
      h(:,j)=k*ha;
end
t=twiddlelkfn(n); 
for i=1:r
    for j=1:c
        u(i,j)=t(i,j);
    end
end
g=h.*u;
for i=1:r 
fa=g(i,:);
  ka=twiddlelkfn(c);
    f(i,:)=fa*ka;   
   end
for i=1:c
    for j=1:r
        z(v)=f(j,i);
        v=v+1;
    end
end
divop=z;
end
