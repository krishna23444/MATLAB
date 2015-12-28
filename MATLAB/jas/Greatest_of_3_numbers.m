%Greatest of 3 numbers.
clc

n1 = input('Enter n1 = ');
n2 = input('Enter n2 = ');
n3 = input('Enter n3 = ');

if n1 > n2 && n1 > n3
    disp('n1 is greatest');
elseif n2 > n1 && n2 > n3
    disp('n2 is greatest');
elseif n3 > n1 && n3 > n2
    disp('n3 is greatest');
end