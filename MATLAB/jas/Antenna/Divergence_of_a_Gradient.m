%Divergence of a Gradient.
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x , y] = meshgrid (-2 : 1 : 2 );
f = x;                              
[dfx , dfy] = gradient(f, 1, 1);    
Ax = dfx;    
Ay = dfy;
divA = divergence(x , y , Ax , Ay);         
if divA == del2(f)
    disp('Div ( Grad f ) = Laplacian  f');
else
    disp('Formula is incorrect');
end