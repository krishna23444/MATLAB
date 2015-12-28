clc
clear all

x=input('enter the sequence');
z=input('enter the response sequence');
N=length(x);
M=length(z);
syms a;
if M<N
   for i=1:N
         y(i)=x(i)*a^(-i);
         b(i)=z(i)*a^(-i);         
   end
   for i=1:N
         c(i)=y(i)*b(i);
     end
     
else
    for i=1:M
       y(i)=x(i)*a^(-i);
         b(i)=z(i)*a^(-i);

    end
     for i=1:M
         c(i)=y(i)*b(i);
     end
     
end

c