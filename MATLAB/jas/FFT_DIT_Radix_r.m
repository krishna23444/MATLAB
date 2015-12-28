%Radix-r Decimation in Time FFT.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

%% Input Radix-r. 
while true
    %Variable r = Radix to be used for FFT.
    r = input('Enter the radix, r = ');
    
    %r must be greator than or equal to 2.
    if r < 2
        disp('r must be greator than or equal to 2.');
        disp(' ');
        continue;
    else
        break;
    end
end

disp(' ');

%% Input N. 
while true
    %Variable N = Number of equidistant samples of DTFT X(w).
    N = input('Enter the number of samples, N = ');
    
    %N must be greator than or equal to 2.
    if N < 2
        disp('N must be greator than or equal to 2.');
        disp(' ');
        continue;
    end
    
    %log N (with base r) must be an integer.
    if r^(floor(log(N)/log(r))) == N
        break;
    else
        disp('log N (with base r) is not an integer. Thus, extra zeros will be padded.');
        break;
    end
end 
   
%% Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
    x(n) = input(sprintf('x(%d) = ',n));   
end

c = N;
while ((r^floor(log(c)/log(r))) ~= c)
    c = c + 1;
end
    
x = [x ; zeros(c - N,1)];
N = size(x,1);
px = x;

%% Digit-reverse the sequence x(n).
x = Digit_Reverse(x,r);

%% Radix-r FFT using decimation in time implementation.
for a = 1 : (log(N)/log(r))
    for b = 1 : (N/(r^a))
        tw = 0;
        for c = (b - 1)*(r^a) + 1 : (b - 1)*(r^a) + r^(a-1)
            z = zeros(r,1);
            e = c;
            for d = 1:r
                z(d) = (exp(-2i*(d-1)*tw*pi/N) * x(e));
                e = e + r^(a-1);
            end
            
            %Radix-r DIT using Divide and Conquer.
            z = dft_DC(z);
            
            e = c;            
            for d = 1:r                  
                  x(e) = z(d); 
                  e = e + r^(a-1);
            end
            
            tw = tw + N/(r^a);
        end
    end
end

%% Show Final Result.
disp(' ');
disp('Radix-r FFT DIT, X(w) = ');
disp(x);

X = x;
x = px;