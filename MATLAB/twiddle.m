function y = twiddle(k,n)
p=isnan(k);
if p==0;
    y=exp(-j*2*pi*k/n);
else
    y=0;
end



