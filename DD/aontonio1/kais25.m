clc
clear all

format long G
tic
S1=2^18
S2=2^17
L=1;
% m=0.795774715459477;
m=0.477464829275686;
p=.8
%2^20=1048576
%2^19=528244
%2^18=262144

 for i=1:S2
        d(i)=(pi/S2)*i;
 end
 
for  N=21

    n=(N-1)/2;
    l=1;    
    

for i=-n:n
    h(n+i+1)=cos(i*pi)/i;
end
h(n+1)=0;

for alp=0:.05:13
     q=1;   
     r=kaiser(2*n+1,alp);
    Q=r.*h';
    y=abs(fft(Q,S1));
%    figure(1)
%    plot(y)

   
    for i=ceil(m*p*S2):ceil(m*S2)
        e(q)=abs(y(i)-d(i));
        q=q+1;
    end

    
    L(l)=max(e);
    l=l+1;


end

figure(2)
semilogy(L)
hold on
grid on
end
toc