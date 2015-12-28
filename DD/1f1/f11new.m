clc
clear all
close all
format long G
a=input('enter value of a ');
b=input('enter value of b  ');

del=.02;

s=1;
X=ones(1,95);
Y=ones(1,95);
for phi=0.1*pi:.01:.4*pi
   
     q=1;
    N=1;
    Vd(s)=hypergeom(a,b,-1i*csc(2*phi));
    while  abs(X(q,s))>(del/100)*abs(real(Vd(s))) && abs(Y(q,s))>(del/100)*abs(imag(Vd(s)))
    q=q+1;
    syms x;
    h=hypergeom(a,b,x);
    t=taylor(h,N);
    x=-1i*csc(2*phi);
    V(q,s)=subs(t);
    X(q,s)=real(Vd(s)-V(q,s));
    Y(q,s)=imag(Vd(s)-V(q,s));
    N=N+1
    end
s=s+1;
end
Z=complex(X,Y);
surf(20*log10(abs(Z)))
% figure(1)
% plot(2:length(e),abs(e(2:length(e))))    
    


    