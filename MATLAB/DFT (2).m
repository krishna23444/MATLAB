clc

N = input('Enter N = ');
x = zeros(N,1);
disp('Enter input sequence.');
for a = 1:N
   x(a) = input(sprintf('x(%d) = ',a));   
end

W = zeros(N,N);

for a = 1:N
    for b = 1:N
        W(a,b) = exp(-i*2*((a-1)*(b-1))*pi/N);
    end
end

y = W * x;
x = (1/N) * conj(W) * y;
disp('DFT = ');
disp(y);
disp('IDFT = ');
disp(x);
