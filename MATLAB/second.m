clc
clear all
x =input('enter start and end');
v=1;
for i=x(1):x(2)
       if isprime(i,3)==1
       z(v)= i;
       v=v+1;
    end
 end
z