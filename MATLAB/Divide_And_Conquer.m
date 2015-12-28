clc
clear

N = input('Enter N = ');

if N < 3
    disp('Divide & Conquer Approach not feasible.');
    return;
end

x = zeros(N,1);
disp('Enter input sequence.');
for a = 1:N
   x(a) = input(sprintf('x(%d) = ',a));   
end

if isprime(N)
    N = N + 1;
    x = [x ; 0];
end

L = max(factor(N));
M = N/L;

if L > M
    t = L;
    L = M;
    M = t;
end

WL = zeros(L,L);
for a = 1:L
    for b = 1:L
        WL(a,b) = exp(-i*2*((a-1)*(b-1))*pi/L);
    end
end

WM = zeros(M,M);
for a = 1:M
    for b = 1:M
        WM(a,b) = exp(-i*2*((a-1)*(b-1))*pi/M);
    end
end

WN = zeros(N,N);
for a = 1:N
    for b = 1:N
        WN(a,b) = exp(-i*2*((a-1)*(b-1))*pi/N);
    end
end

%Step I
X = zeros(L,M);
c = 1;
for a = 1:L
    for b = 1:M
        X(a,b) = x(c);
        c = c + 1;
    end
end

%Step II
for a = 1:M
    X(1:L,a) = WL * X(1:L,a);
end

%Step III
X = X .* WN(1:L,1:M);

%Step IV
for a = 1:L
    X(a,1:M) = (WM * X(a,1:M).').';
end

disp('DFT = ');
disp(X(1:N).');
