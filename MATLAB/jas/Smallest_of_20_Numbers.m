%Smallest of 20 Numbers.
clc
clear

n = rand (1,20);

disp('Random Numbers = ');
disp(n);

smallestNum = n(1);
for i = 1:length(n)
    if n(1,i) < smallestNum
        smallestNum = n(i);
    end
end

disp('Smallest Number is = ');
disp(smallestNum);