clc;
clear;

theta = -pi : pi/100 : pi;
phi = 0 : pi/100 : (2*pi);

U = sin(theta).^2;

figure('Name','Hertz Dipole Radiation Patterns','NumberTitle','off','Units','normalized','Position',[0.05 .05 .9 .85],'Color','w');
subplot(2,3,1);
polar(theta,U);
set(gca,'View',[-90 90],'YDir','reverse');
title('Elevation Plane','FONTSIZE', 14);
t_el = title('Elevation Plane' ,'FONTSIZE', 14);
t_pos = get(t_el,'position');
t_pos(1) = t_pos(1) + 0.1;
set(t_el,'position',t_pos) 
        
theta = pi/2;
U = sin(theta).^2;
U = repmat(U,1,201);
subplot(2,3,4);
polar(phi,U);
set(gca,'View',[-90 90],'YDir','reverse');
t_az = title('Azimuthal Plane' ,'FONTSIZE', 14);
t_pos = get(t_az,'position');
t_pos(1) = t_pos(1) + 0.1;
set(t_az,'position',t_pos) 

theta = -pi : pi/100 : pi;
[phi_3d,theta_3d] = meshgrid(phi,theta);

R = sin(theta_3d).^2;

[X,Y,Z] = sph2cart(phi_3d, pi/2-theta_3d , R);

subplot(2,3,[2 3]);
surf(X,Y,Z);
title('3D Radiation Pattern','FONTSIZE', 14);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

k = 2*pi;
d = k/50 + 0.001;

[x,y] = meshgrid(-k:d:k, -k:d:k);

r = 30;

for j = 1:r
    kr = sqrt(x.^2 + y.^2);
    sin_theta_sq = (x ./ kr).^2;
    cos_phi = cos(kr - j*k/r);
    sin_phi = sin(kr - j*k/r);
    z = sin_theta_sq .* ( sin_phi + cos_phi./kr );
    
    vct = [-1 -0.9 -0.8 -0.75 -0.5 -0.25 -0.1 -0.05 0 0.05 0.1 0.25 0.5 0.75 0.8 0.9 1];
    
    subplot(2,3,[5 6]);
    contour(z,vct);
    
    title('Electric field Lines','Fontsize',14);
    
    axis equal;
    axis off;    

end

figure('Name','Electric field around a Hertzian dipole','NumberTitle','off','Units','normalized','Position',[.1 .1 .8 .8],'Color','w');

for j = 1:r
    kr = sqrt(x.^2 + y.^2);
    sin_theta_sq = (x ./ kr).^2;
    cos_phi = cos(kr - j*k/r);
    sin_phi = sin(kr - j*k/r);
    z = sin_theta_sq .* ( sin_phi + cos_phi./kr );
    
    vct = [-1 -0.9 -0.8 -0.75 -0.5 -0.25 -0.1 -0.05 0 0.05 0.1 0.25 0.5 0.75 0.8 0.9 1];
    
    contour(z,vct);
    
    title('Electric field around a Hertzian dipole','Color',[.5 0 0],'Fontsize',14);
    
    axis equal;
    axis off;    

    M(j) = getframe;
end
movie(M,50,10);