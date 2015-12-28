%DFT using Divide and Conquer, recursively.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

%Variable N = Number of equidistant samples of DTFT X(w).
N = input('Enter the number of samples, N = ');

%Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
   x(n) = input(sprintf('x(%d) = ',n));   
end

%If N is a prime number, then make it non-prime by zero-padding to x(n).
if isprime(N)
    if N == 2
        N = 4;
        x = [x ; 0; 0];
        disp(' ');
        disp('N must be a non-prime number.');
        disp('Thus, two zeros are padded to the input sequence x(n).');
    else
        N = N + 1;
        x = [x ; 0];
        disp(' ');
        disp('N must be a non-prime number.');
        disp('Thus, one zero is padded to the input sequence x(n).');
    end
end

disp(' ');
disp('DFT X(k) = ');
disp(dft_DC(x));