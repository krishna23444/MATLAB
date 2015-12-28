clc
clear all

a=input('enter membership values of first fuzzy set');

b=input('enter membership values of second fuzzy set');

disp('input sets are')
a
b

%union
for i=1:length(b)
    aub(i)=max(a(i),b(i));
end
%intersection
for i=1:length(b)
    aib(i)=min(a(i),b(i));
end
%difference
bc=1-b;

for i=1:length(b)
    adb(i)=min(a(i),bc(i));
end
% cartesian product
k=1
for n = 1 : length(a)
    for m = 1 : length(b)
        acrob(k,1) = a(n);
        acrob(k,2)=b(m);
        k=k+1;
    end
end
disp('a union b:-')
aub
disp('a intersection b:-')
aib
disp('a difference b:-')
adb
disp('a cartesian product b:-')
acrob


