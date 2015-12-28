clc
clear all

format long G

tic
omegap=input('enter passband edge(0-pi)=');
pow=input('enter no. of fft points (2^x) ;x= ');
N=input('enter no. of points in differentiator = ' );
m=omegap/pi;
S2=2^pow;
L=1;
%m=0.795774715459477;
% m=0.477464829275686;
p=.8

q=1;
for i=ceil(m*p*S2):ceil(m*S2)
d(q)=(pi/S2)*i;
q=q+1;
end
 

    n=(N-1)/2;
    l=1;    
    

for i=-n:n
    h(n+i+1)=cos(i*pi)/i;
end
h(n+1)=0;

for alp=0:.05:13
       
    for i=-n:n
        r(i+n+1)=besseli(0,alp*sqrt(1-(2*i/(N-1))^2))/besseli(0,alp);
    end
    Q=r.*h;
    AA=ceil(m*S2)-ceil(m*p*S2)+1;
    [y,P]=freqz(Q,1,linspace(p*omegap,omegap,AA));
    y=abs(y);

   
    for i=1:AA
        e(i)=abs(y(i)-d(i));
        
    end

    
    L(l)=max(e);
    l=l+1;


end

figure(2)
semilogy(L)
hold on
grid on

toc