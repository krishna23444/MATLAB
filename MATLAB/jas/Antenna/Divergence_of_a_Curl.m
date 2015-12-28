%Divergence of a Curl.
clc                 %Clear the Command Window.
clear               %Clear all variables and functions from memory.

[x, y, z] = meshgrid (-1 : 0.3 : 1);
Ax = -y; 	Ay = x;  	Az = 0.*z;			

[curlx, curly, curlz] = curl(x, y, z, Ax, Ay, Az);              %Curl of A.

div = divergence(x , y , z , curlx , curly , curlz);            %Divergence of A.

surf ( x (: , : , 1) , y (: , : , 1 ) , div ( : , : , 1 ) )     %To draw the surface plot.
title('Divergence of a Curl', 'FontSize' , 16)
xlabel('X - axis' , 'FontSize' , 12)
ylabel('Y - axis' , 'FontSize' , 12)
zlabel('Z - axis' , 'FontSize' , 12)