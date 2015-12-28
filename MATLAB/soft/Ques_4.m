% Hamming Distance w.r.t BAM.

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

X = 2*A - 1;
Y = 2*B - 1;

%% Calculate the CORRELATION Matrix, M.

N = size(A,1);

M = zeros(size(A,2), size(B,2));

for n = 1 : N
    M = M + (X(n,:)') * Y(n,:);
end

%% Display the matrix M.

disp('Hetro-correlator (BAM) stores the patterns as :-');
disp(' ');
disp(M);

%% Retreive an associated pattern.

alpha = A(3,:);
alpha(1) = ~alpha(1)

disp('Given pattern(noisy) is :-');
disp(' ');
disp(alpha);

minIndex = 1;
minHammDist = sum(abs(alpha - A(1,:)));

for n = 2 : N
    if minHammDist > sum(abs(alpha - A(n,:)));
        minIndex = n;
        minHammDist = sum(abs(alpha - A(n,:)));
    end
end

beta = B(minIndex,:)

disp('Recalled associated pattern is :-'); 
disp(' ');
disp(beta);