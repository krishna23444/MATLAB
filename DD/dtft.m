clc
clear all
N=11;
a=1
V(1:N,2:N)=[zeros(1,N-1);eye((N-1)/2) fliplr(eye((N-1)/2));fliplr(eye((N-1)/2)) -eye((N-1)/2)];
V(1,1)=sqrt(2);
V=V/sqrt(2);

for i=1:N
H(i,i)=2*cos(2*pi*(i-1)/N)-4;
if i<N
H(i+1,i)=1;
H(i,i+1)=1;
end
end

H(1,N)=1;
H(N,1)=1;
H=-H/(4*pi);


S=V*H;
S=S*V';

G1=S(1:floor(N/2)+1,1:floor(N/2)+1);
G2=S(floor((N-1)/2)+2:N,floor((N-1)/2)+2:N);

[X1,Y1]=eig(G1);
[X2,Y2]=eig(G2);


if mod(N,2)==1
    for i=0:(N-1)/2
        U(:,2*i+1)=([X1(:,i+1)' zeros(1,N-floor((N/2)+1))]*V)';
        
    end
    for i=0:((N-1)/2)-1
        U(:,2*(i+1))=([zeros(1,N-floor(N/2)) X2(:,i+1)']*V)';
    end
    
else
    for i=1:N/2
         U(:,2*i)=([zeros(1,N-floor(N/2)) X2(:,i)']*V)';
         U(:,2*(i-1)+1)=([X1(:,i)' zeros(1,N-floor((N/2)+1))]*V)';
    end
end



for m=1:N
    for n=1:N
        sum=0;
      for k=0:N-mod(N,2)
          sum=sum+U(m,k+1)*U(n,k+1)*exp(-j*pi*k*a/2);
      end
    Fa(m,n)=sum;
    end
end
   Fa=Fa*(1/Fa(1,1))
    
    
    
    
    
    