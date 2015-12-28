%DFT using Divide and Conquer.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

%% Variable N = Number of equidistant samples of DTFT X(w).
N = input('Enter the number of samples, N = ');

%% Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
   x(n) = input(sprintf('x(%d) = ',n));   
end

%% If N is a prime number, then make it non-prime by zero-padding to x(n).
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

%% Make factors, N = LM
L = max(factor(N));
M = N/L;

%% If L is greator than M, then swap L & M.
if L > M
    t = L;
    L = M;
    M = t;
end

%% Twiddle Matrices for L,M and N-Points.
WL = Twiddle(L);
WM = Twiddle(M);
WN = Twiddle(N);

%% Step I - Store the input x(n) row-wise in an L x M matrix X.
X = zeros(L,M);
c = 1;
for a = 1:L
    for b = 1:M
        X(a,b) = x(c);
        c = c + 1;
    end
end

%% Step II - Compute L-point DFT of each column of matrix X.
for a = 1:M
    X(1:L,a) = WL * X(1:L,a);
end

%% Step III - Multiply each element of X with the corresponding element of L x M matrix extracted from the twiddle matrix WN.
X = X .* WN(1:L,1:M);

%% Step IV - Compute M-point DFT of each row of matrix X.
for a = 1:L
    X(a,1:M) = (WM * X(a,1:M).').';
end

disp(' ');
disp('DFT X(k) = ');
disp(X(1:N).');