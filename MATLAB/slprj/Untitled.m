T=2
N=5
D=2*pi/(N*T);
n=0:N-1
x=exp(-.1*n*T);
X=T*fftshift(x);
m=-N-1/2:(N-1)/2;
plot(m*D,abs(X))
