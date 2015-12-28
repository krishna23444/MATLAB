
%Emmanuel Candes, Californianm = 64;                            %&nbsp;% Number of samples (undersample by a factor 8)

k = 0:n-1;  t = 0:n-1;
F = exp(-i*2*pi*k'*t/n)/sqrt(n);   %&nbsp;% Fourier matrix
freq = randsample(n,m);
A = [real(F(freq,:));
     imag(F(freq,:))];             %&nbsp;% Incomplete Fourier matrix

S = 28;
support = randsample(n,S);
x0 = zeros(n,1);  x0(support) = randn(S,1);
b = A*x0;

cvx_quiet(true);
%cvx_solver('sedumi');

%convex iteration
y = ones(n,1);
while 1
   %&nbsp;% Solve l0 using CVX and Convex Iteration
    cvx_begin
        variable x(n);
        minimize(norm(y.*x,1));
        A*x == b;
    cvx_end

   %&nbsp;% update search direction y
    [x_sorted, indices] = sort(abs(x), 'descend');  
    y = ones(n,1);
    y(indices(1:S)) = 0;

    cardx = sum(abs(x))
    if cardx &lt= S, break, end
end
norm(x - x0)/norm(x0)
figure, plot(1:n,x0,'b*',1:n,x,'ro'), legend('original','decoded')
