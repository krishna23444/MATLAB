function c = dftr2(x)
% Recursive Decimation-in-Frequency FFT algorithm, csb 8/21/07
L = length(x);
if L > 1
L2 = L/2;
TF = exp(-j*2*pi/L).^[0:L2-1];
c1 = dftr2( x(1:L2) + x(L2+1:L));
c2 = dftr2((x(1:L2) - x(L2+1:L)).*TF);
cc = [c1';c2'];
c = cc(:);
else
c = x;
end