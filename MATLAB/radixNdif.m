clc
clear all

x=input('enter the sequence');
M=input('enter the radix');
N1=length(x);
H=M^(ceil(log(N1)/log(M)))-N1;
x=[x,zeros(1,H)];
N=length(x);
n = round(log(N)/log(M));
L=N/M;
U(:,1)=x.';
v=1;
for j=1:M
    for i=1:L
        y(j,i)=x(v);
        v=v+1;
    end
end

 if n==1
     U(:,2)=(x*w(M)).';
 else
 for k=1:n-1
   
   O=0;
    
   for i=1:N/M
        y(:,i,k)=w(M)*y(:,i,k);
   end
   
  
   for a=0:M^(k-1)-1
        
  Y=y(:,a*L+1:(a+1)*L,k);
  
  for i=1:L
       for j=1:M
    Y(j,i)=twid(j,i,L*M)*Y(j,i);
       end
  end
y(:,a*L+1:(a+1)*L,k)=Y;
v=1;
for j=1:M
    for i=1:L    
I(v)=Y(j,i);
v=v+1;
    end
end
U(a*L*M+1:(a+1)*L*M,k+1)=I.';
clear I
   end
                                                              
   if L~=M
       
     L=L/M;
    
  for a=0:M^(k-1)-1
       for u=1:M
      x=y(u,a*M*L+1:(a+1)*M*L,k);
      
      v=1; 
     for j=1:M
       for i=1:L
        y(j,O*(L)+i,k+1)=x(v);
        v=v+1;
       end
      end
    O=O+1;
        end
  end
   
   end
 end

for a=0:M^(n-2)-1
     for u=1:M
      y(u,a*M+1:(a+1)*M,n-1)=y(u,a*M+1:(a+1)*M,n-1)*w(M);
     end
end


for k=n-2:-1:1
    
    for a=0:M^k-1
    z=y(:,a*L+1:(a+1)*L,k+1);
    Z(:,a+1)=z(:);
    end
    
    v=1;
    for a=1:M^(k-1)
        for h=1:M
            
    y(h,(a-1)*M*L+1:a*M*L,k)=Z(:,v);
       v=v+1;
        end
    end
    L=L*M;
    clear Z z
end
X=y(:,:,1);
DFT=X(:).';
U(:,n+1)=X(:);
 end
sprintf('The %6.0d point DIF FFT ,at the input and output of different stages, of the sequence using radix %2.0d is',N,M),disp(U);