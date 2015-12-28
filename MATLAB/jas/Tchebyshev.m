clc;
clear all;
m = input ('Enter the number of elements in an array');

f = factor ( m );
lambda = 1;
d = lambda / 2;
theta = 0 : pi;
an = 1;
u = (pi * d / lambda) * cos (theta);

if f(1) == 2
    n = 1 : m/2;
    AF = an * cos ((2 * n-1) * u);

else
    n = 1 : m/2 + 1;
    AF = an * cos ((2 * n-1) * u);
end
plot (AF);
    

if -1 <= z <= 1
    T = cos ( m * acosd(z) );
else
    T = cosh ( m * log ( z + ( z^2 - 1 ) ^0.5));
end
plot (T);
