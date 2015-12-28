clear;

lambda = 1;
k = 2 * pi / lambda;

theta = -pi : pi/100 : pi;

l = lambda / 100;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U); 
polar(theta,U,'-k');

hold on;

l = lambda / 4;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U); 
polar(theta,U,'--r');

l = lambda / 2;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U);  
polar(theta,U,'.:b');

l = 3 * lambda / 4;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U); 
polar(theta,U,'.-g');

l = lambda;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U); 
polar(theta,U,'c*');

lgd = legend('L = \lambda/100','L = \lambda/4','L = \lambda/2','L = 3*\lambda/4','L = \lambda',5);
set(lgd,'Units','normalized','Position',[0.05 0.05 .25 .2]);

hold off;