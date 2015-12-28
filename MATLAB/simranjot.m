function y=simranjot(l)
theta = -pi : pi/111 : pi;
phi = 0 : pi/111 : (2*pi);
[phi1,theta1] = meshgrid(phi,theta);

[X,Y,Z] = sph2cart(phi1,pi/2-theta1,U(theta1,l));
figure(1)
o=max(U(theta1,l));
mesh(X,Y,Z);
syms th ph

figure(2)
ezpolar(U(th,l));view([90 -90])

fnn=@(x)U(x,l).*sin(x);
g=2*o(1)/quad(fnn,0,pi);
D=10*log10(g);
disp('Directivity(dB) of antenna is')
D
v = 0 : l/100 : l/2;
u =sin(2*pi* (l/2 - v));
g = -l/2 : l/100 : 0;
h = sin(2*pi* (l/2 + g));
figure(3)
plot( [g v],sqrt(([h u]).^2));
title('current distribution')



function y=U(x,l)
y=((cos(2*pi*l*cos(x)/2) - cos(2*pi*l/2))./sin(x)).^2;




