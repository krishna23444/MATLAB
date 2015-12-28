function y = radix2ifft(x)
len = length(x);
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
        w=twiddle2(2^p);   
        t2=t2.*(w(1:2^(p-1),2));
        h(q:q+2^(p-1)-1,p+1) = t1+t2;
        h(q+2^(p-1):q+2^(p-1)+2^(p-1)-1,p+1) = t1-t2;
    end
end
for k=1:len
    y(k) = (h(k,m+1))/len; 
end
    

