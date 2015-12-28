%Curl of a Gradient.
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x , y, z] = meshgrid (-2 : 0.9 : 2 );
f = x;                                          %Scalar function f.

[dfx , dfy, dfz] = gradient(f, 1, 1, 1);    	%Gradient of f.

[curlx, curly, curlz] = curl(x, y, z, dfx, dfy, dfz);		
quiver3(x, y, z, curlx, curly, curlz) 				
title ('Curl of a Gradient is ZERO', 'FontSize', 16) 
xlabel('X - axis', 'FontSize', 14) 
ylabel ('Y - axis', 'FontSize', 14)
zlabel ('Z - axis', 'FontSize', 14)