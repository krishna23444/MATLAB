function y=WN(N);
for p=1:N
    for j=1:N
        y(p,j)=exp(-(p-1)*(j-1)*2*pi*i/N);
    end
end
