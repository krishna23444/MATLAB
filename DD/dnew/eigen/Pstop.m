function [p] = Pstop(n,m,wp1,wp2)
%Pstop	function to calculate the n,mth element of the Pstopband matrix
%	for the Eigenfilter P matrix 
%	wp1 and wp2 are assumed to be normalized w.r.t pi
%	it can be thought of as the integral FROM wp1 TO wp2
if (n == 0 & m == 0)
 p = wp2*pi-wp1*pi;
elseif (m == 0)
 p = (sin(pi*n*wp2))/n - (sin(pi*n*wp1))/n;
elseif (n == 0)
 p = (sin(pi*m*wp2))/m - (sin(pi*m*wp1))/m;
elseif (n == m)
 p = (0.5*cos(pi*m*wp2)*sin(pi*m*wp2) + .5*m*pi*wp2)/m ...
   - (0.5*cos(pi*m*wp1)*sin(pi*m*wp1) + .5*m*pi*wp1)/m;
else
 p  = (sin(pi*(m+n)*wp2)/(2*(m+n)) + sin(pi*(m-n)*wp2)/(2*(m-n)))   ...
    - (sin(pi*(m+n)*wp1)/(2*(m+n)) + sin(pi*(m-n)*wp1)/(2*(m-n)));
end

