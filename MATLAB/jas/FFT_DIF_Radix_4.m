%Radix-4 Decimation in Frequency FFT.
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
    
    %log N (with base 4) must be an integer.
    if 4^(floor(log(N)/log(4))) == N
        break;
    end
    disp('log N (with base 4) must be an integer.');
    disp(' ');
end

%Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
    x(n) = input(sprintf('x(%d) = ',n));   
end

%W4 = Twiddle Matrix for 4-Points.
W4 = zeros(4,4);
for a = 1:4
    for b = 1:4
        W4(a,b) = exp(-2i*((a-1)*(b-1))*pi/4);
    end
end

%Radix-4 FFT using decimation in frequency implementation.
for a = floor((log(N)/log(4))) : -1 : 1
    for b = 1 : (N/(4^a))
        tw = 0;
        for c = (b - 1)*(4^a) + 1 : (b - 1)*(4^a) + 4^(a-1)
            z = zeros(4,1);
            e = c;
            for d = 1:4
                z(d) = x(e);
                e = e + 4^(a-1);
            end
            
            %Radix-4 DIF Butterfly (4-point DFT).
            z = W4 * z;
            
            e = c;            
            for d = 1:4                  
                  x(e) = exp(-2i*(d-1)*tw*pi/N) * z(d); 
                  e = e + 4^(a-1);
            end
            
            tw = tw + N/(4^a);
        end
    end
end

%Digit-reverse the resulting sequence.
x = digitrevorder(x,4);

disp(' ');
disp('Radix-4 FFT DIF = ');
disp(x);