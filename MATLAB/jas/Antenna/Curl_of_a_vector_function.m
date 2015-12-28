% Curl of a vector function A = -y ax + x ay
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x, y, z] = meshgrid (-1 : 0.3 : 1);
Ax = -y; 	Ay = x; 		Az = 0.*z;              

[curlx, curly, curlz] = curl(x, y, z, Ax, Ay, Az);	%Curl of A.

quiver3(x, y, z, curlx, curly, curlz) 				%To plot the curl of A.

title ('Curl of a vector function, A = -y a_x + x a_y', 'FontSize', 16) 
xlabel('X - axis', 'FontSize', 14) 
ylabel ('Y - axis', 'FontSize', 14)
zlabel ('Z - axis', 'FontSize', 14)