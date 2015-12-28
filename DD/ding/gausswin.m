function [w] = gausswin(M)

n = -(M-1)/2 : (M-1)/2;
w = exp((-1/2) * (2.5 * n/((M-1)/2)) .^ 2)';