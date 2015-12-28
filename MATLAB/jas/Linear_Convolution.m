%Linear Convolution.
clc
clear

%% Sequence x.
sx = input('Enter the number of elements in sequence x = ');
x = zeros(1,sx);
disp(' ');
disp('Enter the sequence x.');
for n = 1:sx
   x(n) = input(sprintf('x(%d) = ',n));   
end

%% Sequence h.
disp(' ' );
sh = input('Enter the number of elements in sequence h = ');
h = zeros(1,sh);
disp(' ');
disp('Enter the sequence h.');
for n = 1:sh
   h(n) = input(sprintf('h(%d) = ',n));   
end

%% Perform Convolution.
y = zeros(1,length(x) + length(h) - 1);

for n = 1:length(y)
   sum = 0;
   for k = 1 : length(x)
       index = n - k + 1;
       if index >= 1 && index <= length(h)
           sum = sum + ( x(k) .* h(index) );   
       end
   end
   y(n) = sum;
end

%% Show Results.
disp(' ' );
disp('x - Sequence.');
disp(x);
disp('h - Sequence.'); 
disp(h);
disp('Convolution using FOR loop.'); 
disp(y);
disp('Convolution using CONV function.'); 
disp(conv(x,h));