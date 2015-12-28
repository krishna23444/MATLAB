function y=CuDis(l)
v = 0 : l/100 : l/2;
u =sin(2*pi* (l/2 - v));
g = -l/2 : l/100 : 0;
h = sin(2*pi* (l/2 + g));
plot( [g v],sqrt(([h u]).^2));
title('current distribution')
