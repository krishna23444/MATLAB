clc
clear all
x=input('enter the sequence');
N=length(x);
n=log2(N);


for m=1:n
    for t=1:2^(m-1)
       o(t)=N*(t-1)/2^m;
    end
    k(m,:)=repmat(o,1,N/2^m);
    
    for i=1:N/2
    h=1:2^(m-1);
    for j=1:N/2
        h1(m,j)=h(1)+2^(m-1)+1;
    
end


    
    

% for m=1:n
%     
%     for j=1:N/2
        
    