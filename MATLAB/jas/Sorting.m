%Sorting
clc
clear

N = input('Enter the number of elements to sort = ');

n = zeros(N,1);
disp(' ');
disp('Enter the value of the elements.');
for a = 1:N
   n(a) = input(sprintf('Element No. %d = ',a));   
end

for i = 1:size(n)-1
   for j = i+1:size(n)
       if n(i) > n(j)
         t = n(i);
         n(i) = n(j);
         n(j) = t;
       end
   end
end

disp(' ');
disp('Sorted Elements (Ascending).');
disp(n);

for i = 1:size(n)-1
   for j = i+1:size(n)
       if n(i) < n(j)
         t = n(i);
         n(i) = n(j);
         n(j) = t;
       end
   end
end

disp('Sorted Elements (Decending).');
disp(n);