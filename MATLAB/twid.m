function y = twid(k,n,K)
%gives value of twiddle factor at (k,n) of base K twiddle matrix
    y=exp(-j*2*pi*(k-1)*(n-1)/K);



