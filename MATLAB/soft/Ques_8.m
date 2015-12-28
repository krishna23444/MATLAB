% Fuzzy Logic operations.
% Union, Intersection, Difference, Cartesian products.

clc;
clear;

%% Input Sets.
 
A = [ 0.2 0.4 0.6 ];
B = [ 0.1 0.3 0.5 ];

%% Display the input sets.

disp('Input Sets :-');
A
B

%% Union.

disp('A Union B :-');
disp(' ');
AunionB = zeros(1,length(A));
for n = 1 : length(A)
    AunionB(n) = max(A(n),B(n));
end
disp(AunionB);
disp(' ');

%% Intersection.

disp('A Intersection B :-');
AintersectionB = zeros(1,length(A));
for n = 1 : length(A)
    AintersectionB(n) = min(A(n),B(n));
end
disp(AintersectionB);
disp(' ');

%% Difference.

disp('A - B :-');
AdiffB = zeros(1,length(A));
Bc = 1 - B;
for n = 1 : length(A)
    AdiffB(n) = min(A(n),Bc(n));
end
disp(AdiffB);
disp(' ');

%% Cartesian Product.

disp('A X B :-');
disp(' ');
AcrossB = zeros(length(A), length(B));
for n = 1 : length(A)
    for m = 1 : length(B)
        AcrossB(n,m) = min(A(n),B(m));
    end
end
disp(AcrossB);
disp(' ');