x=-10:.1:10;
sig=input('enter variance value=');
mew=input('enter value of mean close to zero');
g=1/sig* sqrt(2*pi);
k=exp((-(x-mew).^2)/(sig*2));
y=g*k/max(g*k);
stem(x,y)

