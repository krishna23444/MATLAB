clc
clear all

z=input('enter the sequence');
N=length(z);
f=fliplr(dec2bin(0:N-1));

for i=1:N
    K(:,i)=z(bin2dec(f(i,:))+1);
end

for j=1:log2(N)
   for i=1:N/2^j
       
       for k=1:2^j
           
        
        
               
               
               
    
    

