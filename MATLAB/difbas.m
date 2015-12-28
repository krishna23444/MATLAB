clc
clear all

z=input('enter the sequence');
N1=length(z);
R=2;
z=[z zeros(1,R^(ceil(log(N1)/log(R)))-N1)];
N=length(z);
L=log2(N);

for j=1:L
    v=0;
    for i=1:N/2^j
          p=(i-1)*(2^j)+1:(i-1)*(2^j)+2^(j-1);
       for l=1:2^(j-1)
           u=L:-1:1;
           v=v+1;
        J(u(j),v)=p(l);
        
       end

    end
end
K(:,1)=z.';
E=1;
for h=L:-1:1
       T=0:2^(L-E)-1;
    
       for i=1:length(T)
           j(i)=N*T(i)/(2^(L-E+1));
           j(1)=0;
       end
y=repmat(j,1,2^(L-h));
     
       for q=0:N/2-1
           K(J(E,q+1),E+1)=(K(J(E,q+1),E)+K(J(E,q+1)+2^(h-1),E));
           K(J(E,q+1)+2^(h-1),E+1)=(K(J(E,q+1),E)-K(J(E,q+1)+2^(h-1),E))*twiddle(y(q+1),N);
       end
     E=E+1;
    j=0;
end

b=0:N-1;
k=dec2bin(b);
f=fliplr(k);
for i=1:N
    K(i,L+2)=K(bin2dec(f(i,:))+1,L+1);
end
disp('DIF RESULT: Input , Output at different stages & Bit Reversed Output'),disp(K);
    


