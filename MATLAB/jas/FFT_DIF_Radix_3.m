%Radix-3 Decimation in Frequency FFT.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

while true
    %Variable N = Number of equidistant samples of DTFT X(w).
    N = input('Enter the number of samples, N = ');
    
    %N must be greator than or equal to 2.
    if N < 2
        disp('N must be greator than or equal to 2.');
        disp(' ');
        continue;
    end
    
    %log N (with base 3) must be an integer.
    if 3^(floor(log(N)/log(3))) == N
        break;
    end
    disp('log N (with base 3) must be an integer.');
    disp(' ');
end

%Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
    x(n) = input(sprintf('x(%d) = ',n));   
end

%W3 = Twiddle Matrix for 3-Points.
W3 = zeros(3,3);
for a = 1:3
    for b = 1:3
        W3(a,b) = exp(-2i*((a-1)*(b-1))*pi/3);
    end
end

%Radix-3 FFT using decimation in frequency implementation.
for a = floor((log(N)/log(3))) : -1 : 1
    for b = 1 : (N/(3^a))
        tw = 0;
        for c = (b - 1)*(3^a) + 1 : (b - 1)*(3^a) + 3^(a-1)
            z = zeros(3,1);
            e = c;
            for d = 1:3
                z(d) = x(e);
                e = e + 3^(a-1);
            end
            
            %Radix-3 DIF Butterfly (3-point DFT).
            z = W3 * z;
            
            e = c;            
            for d = 1:3                  
                  x(e) = exp(-2i*(d-1)*tw*pi/N) * z(d); 
                  e = e + 3^(a-1);
            end
            
            tw = tw + N/(3^a);
        end
    end
end

%Digit-reverse the resulting sequence.
x = digitrevorder(x,3);

disp(' ');
disp('Radix-3 FFT DIF = ');
disp(x);