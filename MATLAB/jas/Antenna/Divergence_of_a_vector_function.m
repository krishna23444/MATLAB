%Divergence of a vector function A = x ax + y ay + z az
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x , y , z] = meshgrid( -1: 0.4 :1 );
Ax = x;   	Ay = y;		Az = z;

div = divergence(x , y , z , Ax , Ay , Az);                     %Divergence of A.

surf ( x (: , : , 1) , y (: , : , 1 ) , div ( : , : , 1 ) )     %To draw the surface plot.
title('Divergence of vector function, A = x a_x + y a_y + z a_z ', 'FontSize' , 16)
xlabel('X - axis' , 'FontSize' , 12)
ylabel('Y - axis' , 'FontSize' , 12)
zlabel('Z - axis' , 'FontSize' , 12)