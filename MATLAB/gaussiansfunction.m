x=1:.1:10
s=2
g=1/(sqrt(2*pi)*s);
m= 5
h=exp(-(x-m).^2/2*s)
y=g*h
stem(x,y)
