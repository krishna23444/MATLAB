function y=errf(x)

      i=0:8;
     y=(2/sqrt(pi)).*(sum(((-1).^i).*(x.^(2.*i+1))./((factorial(i)).*(2.*  i+1))));