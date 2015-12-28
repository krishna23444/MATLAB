% Classical Set theory operations.
% Union, Intersection, Difference, Cartesian products.

clc;
clear;

%% Input Sets.
 
A = [ 1 5 3 7 6 9 10 ];
B = [ 3 6 8 2 11 4 1 ];

%% Display the input sets.

disp('Input Sets :-');
A
B

%% Union.

disp('A Union B :-');
disp(' ');
disp(union(A,B));
disp(' ');

%% Intersection.

disp('A Intersection B :-');
disp(' ');
disp(intersect(A,B));
disp(' ');

%% Difference.

disp('A - B :-');
disp(' ');
disp(setdiff(A,B));
disp(' ');

%% Cartesian Product.

disp('A X B :-');
disp(' ');
Au = unique(A)
Bu = unique(B)
AcrossB = '{';
for n = 1 : length(Au)
    for m = 1 : length(Bu)
        AcrossB = [AcrossB '(' num2str(A(n)) ',' num2str(B(m)) ')'];
    end
end
AcrossB = [AcrossB '}'];
disp(AcrossB);
disp(' ');