clc;
clear all;
close all;
t=1:100;
f=.1;
car = sin(2*pi*f*t);
plot(car);
bin = [];
 for i=1:10
    bin =[ bin input('enter value of 10 bit sequence')];
 end
 bin
 i = 1;
 
 s = zeros(1,100);
 for j = 1:10
    temp = t(j*10 - 10 + 1:j*10);
 
    for k = (j*10 - 10 + 1):j*10
     
     if bin(k) == 0
         
       s(k) = -1 * sin(2*pi*f*temp(k));
     else
         s(k) = sin(2*pi*f*temp(k));
     end
     
 
 
 end
 
  
    
 end
 
 s
 plot(s);
% for i=1:10
%     if Tx(i)==0
%         Tx(i)=;
%     else
%         Tx(i)=-s;
%     end
% end
