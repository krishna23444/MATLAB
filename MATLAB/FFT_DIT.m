clc

while true
    N = input('Enter N = ');
    if mod(N,2) == 0
        break;
    end
    disp('N must be a multiple of 2.');
end

x = zeros(N,1);
disp('Enter input sequence.');

for a = 1:N
   x(a) = input(sprintf('x(%d) = ',a));   
end

y = zeros(1,N);
for a = 1:N
    y(a) = bin2dec(fliplr(dec2bin(a-1,log2(N)))) + 1;
end
px = x;

for a = 1:N
   x(a) = px(y(a));
end

for a = 1 : log2(N)
    for b = 1 : N/(2^a)
        tw = 0;
        for c = (b - 1)*(2^a) + 1 : (b - 1)*(2^a) + 2^(a-1)
            t = x(c);
            x(c) = x(c) + (exp(-2i*(tw)*pi/N)) * x(c + 2^(a-1));
            x(c + 2^(a-1)) = t - (exp(-1i*2*(tw)*pi/N)) * x(c + 2^(a-1)); 
            tw = tw + N/(2^a);
        end
    end
end

disp('DIT FFT  = ');
disp(x);