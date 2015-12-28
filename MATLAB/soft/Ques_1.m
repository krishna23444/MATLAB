% Hopfield-Associative Memory (HAM).

clc;
clear;

%% Training Pattern Pairs.

A = [ -1  1 -1  1 ;  1  1  1 -1 ; -1 -1 -1  1  ];

%% Display the pattern pairs.

disp('Training Pattern Pairs :-');
A

%% Calculate the CONNECTION Matrix, T.

m = size(A,1);

T = zeros(size(A,2), size(A,2));

for n = 1 : m
    T = T + (A(n,:)') * A(n,:);
end

%% Display the result.

disp('Auto-correlator (HAM) stores the patterns as :-');
disp(' ');
disp(T);
disp(' ');