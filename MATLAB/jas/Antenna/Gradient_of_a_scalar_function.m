%Gradient of a scalar function, f = x
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x , y] = meshgrid (-2 : 0.9 : 2 );
f = x;                                      %Scalar function f.

[dfx , dfy] = gradient(f, 1, 1);    		%Gradient of f.

quiver(x, y, dfx, dfy)          			%To draw the gradient.
title('Gradient of a scalar function, f = x', 'FONTSIZE' , 16)
xlabel('X - axis', 'FONTSIZE' , 14)
ylabel('Y - axis', 'FONTSIZE' , 14)