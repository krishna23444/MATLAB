clc
clear all

z=input('enter the sequence');
N=length(z);
L=log2(N);
b=0:N-1;
k=dec2bin(b);
f=fliplr(k);
t(:,1)=z;


  
for j=1:L
    v=0;
    for i=1:N/2^j
          p=(i-1)*(2^j)+1:(i-1)*(2^j)+2^(j-1);
       for l=1:2^(j-1)
           v=v+1;
        J(j,v)=p(l);
        
       end
        
      end
    end


for i=1:N
    g(i)=t(bin2dec(f(i,:))+1);
    
end

K(:,1)=g.';



for h=1:L
   T=0:2^(h-1)-1;
    
    
    for i=1:length(T)
           j(i)=N*T(i)/(2^h);
           j(1)=0;
    end

    y=repmat(j,1,2^(L-h));
    
    for q=0:N/2-1
           K(J(h,q+1),h+1)=K(J(h,q+1),h)+K(J(h,q+1)+2^(h-1),h)*twiddle(y(q+1),N);
           K(J(h,q+1)+2^(h-1),h+1)=K(J(h,q+1),h)-K(J(h,q+1)+2^(h-1),h)*twiddle(y(q+1),N);
      end
    
end

disp('DIT RESULT: Bit Reversed Input , Output at different stages '),disp(K);
    


