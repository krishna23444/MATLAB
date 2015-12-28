function y = radix2iftlkfn(x)
x=rot90(x);
len = length(x);
n1=len;
nf=ceil(log2(len));
while (nf ~= (log2(n1)))
       n1=n1+1;
       
end
lenmn=n1-len;
x=[x zeros(1,lenmn)];
len=length(x);
m = log2(len);
k = [0:len-1];
b = dec2bin(k,m);
bf = fliplr(b);
kf = bin2dec(bf);
for i=1:length(kf)
    xin(i,1) = x(kf(i)+1);
end
h=zeros(len,m+1);
h(:,1)=xin;
for p=1:m
    for q=1:2^p:len
        t1=h(q:q+2^(p-1)-1,p);
        t2=h(q+2^(p-1):q+2^(p-1)+2^(p-1)-1,p);
        w=twiddle2lkfn(2^p);   
        t2=t2.*(w(1:2^(p-1),2));
        h(q:q+2^(p-1)-1,p+1) = t1+t2;
        h(q+2^(p-1):q+2^(p-1)+2^(p-1)-1,p+1) = t1-t2;
    end
end
for k=1:len
    y(k) = (h(k,m+1))/len; 
end
    

