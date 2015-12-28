syms L
K=2*pi/L
l=.01*L
th=0:0.01:pi
ezpolar(cos(K*(l/2)*cos(th))-cos(K*l/2)^2/sin(th)*sin(th))
