% Bidirectional-Associative Memory (BAM).

clc;
clear;
  
%% Training Pattern Pairs.

A = [ 1 0 0 0 0 1 ; 
      0 1 1 0 0 0 ; 
      0 0 1 0 1 1 ];
  
B = [ 1 1 0 0 0 ; 
      1 0 1 0 0 ; 
      0 1 1 1 0 ];
  
%% Display the pattern pairs.

disp('Training Pattern Pairs :-');
A
B

%% Convert the Training Pattern Pairs to bipolar form.  

X = 2*A - 1
Y = 2*B - 1

%% Calculate the CORRELATION Matrix, M.

N = size(A,1);

M = zeros(size(A,2), size(B,2));

for n = 1 : N
    M = M + (X(n,:)') * Y(n,:);
end

%% Display the result.

disp('Hetro-correlator (BAM) stores the patterns as :-');
disp(' ');
disp(M);
disp(' ');