clc;
clear;

lambda = 1;
l = input('Enter length of the dipole = ') * lambda;

k = 2 * pi / lambda;

I0 = 1;
z1 = 0 : l/200 : l/2;
I1 = I0 * sin(k * (l/2 - z1));

z2 = -l/2 : l/200 : 0;
I2 = I0 * sin(k * (l/2 + z2));

plot([I2 I1], [z2 z1]);
title('Current Distribution','FONTSIZE', 14);
ylabel('Z - axis','FONTSIZE', 14);

theta = -pi : pi/100 : pi;
phi = 0 : pi/100 : (2*pi);

U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = U ./ max(U);
figure
subplot(1,2,1);
polar(theta,U);

title('Elevation Plane','FONTSIZE', 14);

theta = pi/2;
U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
U = repmat(U,1,201);
subplot(1,2,2);
polar(phi,U);
title('Azimuthal Plane','FONTSIZE', 14);

theta = -pi : pi/100 : pi;
[phi_3d,theta_3d] = meshgrid(phi,theta);

U = ( (cos(k*l*cos(theta_3d)/2) - cos(k*l/2)) ./ sin(theta_3d) ) .^ 2;

[X,Y,Z] = sph2cart(phi_3d,pi/2 - theta_3d  , U);

figure;
surf(X,Y,Z);
title('3D Radiation Pattern','FONTSIZE', 14);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
