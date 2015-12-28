% Hopfield's Energy function.

clc;
clear;
  
%% Input Patterns.

A = [ 1 0 0 0 ; 
      0 1 1 0 ; 
      0 0 1 0 ];

%% Display the patterns.

disp('Input Patterns :-');
A

%% Convert the Training Patterns to bipolar form.  

X = 2*A - 1;

%% Calculate the CORRELATION Matrix, M.

N = size(A,1);

M = zeros(size(A,2), size(A,2));

for n = 1 : N
    M = M + (X(n,:)') * X(n,:);
end

%% Display the CORRELATION matrix, M.

disp('CORRELATION Matrix, M :-');
disp(' ');
disp(M);

%% Calculate the ENERGY FUNCTION, E.

E = -X * M * X'
E = sum(sum(E))

disp('Energy Function, E :-');
disp(' ');
disp(E);
disp(' ');