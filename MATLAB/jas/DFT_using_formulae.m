%DFT using formulae.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

%Variable N = Number of equidistant samples of DTFT X(w).

x=input('enter the sequence');
N = length(x);
%Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
   x(n) = input(sprintf('x(%d) = ',n));   
end

%WN = Twiddle Matrix for N-Points.
WN = zeros(N,N);
for a = 1:N
    for b = 1:N
        WN(a,b) = exp(-2i*((a-1)*(b-1))*pi/N);
    end
end

%DFT
y = WN * x;
disp(' ');
disp('DFT X(k) = ');
disp(y);

%IDFT
x = (1/N) * conj(WN) * y;
disp('IDFT x(n) = ');
disp(x);