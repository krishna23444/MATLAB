function WN = Twiddle(N)
    %Twiddle(N) 
    %Returns an N-point Twiddle Matrix.
    WN = zeros(N,N);
    for a = 1:N
        for b = 1:N
            WN(a,b) = exp(-2i * ( (a-1) * (b-1) ) * pi / N);
        end
    end
end