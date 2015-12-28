function y=iod(x)
k=1:25;
y=(2/x)*sum(k.*(((x./2).^k)./factorial(k)).^2);
if x==0
    y=0;
end

