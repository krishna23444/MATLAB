m=input('od4j ifog henbodcznych');
i=1:m;
cn=sin(i*pi/2)./(i*pi);
a=[0.5 2*abs(cn)];
fi_a=[ 0 angle(cn)+pi/2];
t=0:(0.001/(6*m)):0.02;
y=sin(a,fi_a,100,t);
plot(t,y);