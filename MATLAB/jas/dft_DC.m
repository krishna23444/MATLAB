function f = dft_DC(x)
    %dft_DC(x)
    %Returns DFT of a sequence x using Divide & Conquer Approach.
    %
    %If the sequence x contains prime number of samples, then DFT is calculated
    %using the DFT formulae, otherwise the divide & conquer approach is applied 
    %recursively.
    %
    %If the input matrix sequence x is neither a row-matrix nor a column-matrix
    %then, x is converted into a row matrix by reading its elements row wise. 

    N = size(x);
    y = zeros(N(1)*N(2),1);
    c = 1;
    for a = 1 : N(1)
        for b = 1 : N(2)
            y(c) = x(a,b);
            c = c + 1;
        end
    end

    x = y;

    N = N(1)*N(2);

    if isprime(N)
        f = Twiddle(N)*x; 
        return;
    end

    %Make factors, N = LM
    L = max(factor(N));
    M = N/L;

    %Step I - Store the input x(n) row-wise in an L x M matrix X.
    X = zeros(L,M);
    c = 1;
    for a = 1:L
        for b = 1:M
            X(a,b) = x(c);
            c = c + 1;
        end
    end

    %Step II - Compute L-point DFT of each column of matrix X.
    for a = 1:M
        X(1:L,a) = dft_DC(X(1:L,a));
    end

    %Step III - Multiply each element of X with the corresponding element of L x M matrix extracted from the twiddle matrix WN.
    WN = Twiddle(N);
    X = X .* WN(1:L,1:M);

    %Step IV - Compute M-point DFT of each row of matrix X.
    for a = 1:L
        X(a,1:M) = dft_DC(X(a,1:M).').';
    end

    f = X(1:N).';
end