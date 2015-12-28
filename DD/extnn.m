function y=extnn(x,m,n)

s=size(x);
y=x;
for h=s(1)+1:m
    y(h,1)=0;
end

for d=s(2)+1:n
    y(1,d)=0;
end
