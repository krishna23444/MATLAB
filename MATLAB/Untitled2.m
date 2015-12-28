function y=linwire(l)

lambda = 1;
l=l*lambda;

k = 2 * pi / lambda;
theta = -pi : pi/100 : pi;
phi = 0 : pi/100 : (2*pi);
[phi_3d,theta_3d] = meshgrid(phi,theta);
U = ( (cos(k*l*cos(theta_3d)/2) - cos(k*l/2)) ./ sin(theta_3d) ) .^ 2;
[X,Y,Z] = sph2cart(phi_3d,pi/2 - theta_3d  , U);

figure;
surf(X,Y,Z);
title('3D Radiation Pattern','FONTSIZE', 14);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
