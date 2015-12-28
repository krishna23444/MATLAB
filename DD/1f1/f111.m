clc
clear all
close all
format long G
phi=input('enter value of phi ');
b=input('enter value of b  ');
a=input('enter value of a  ');


del=.02;

s=1;
e=ones(1,101);
for mu=0:.01:.99
   
     q=1;
    N=1;
    Vd(s)=hypergeom((a-mu)/2,b,-csc(2*phi));
    while  abs(e(q,s))>(del/100)*Vd(s)
        q=q+1;
    
    syms x;
    h=hypergeom((a-mu)/2,b,x);
    t=taylor(h,N);
    x=-csc(2*phi);
    V(q,s)=subs(t);
    e(q,s)=Vd(s)-V(q,s);
  
    N=N+1
    end
s=s+1;
end
surf(20*log10(abs(e)))
% figure(1)
% plot(2:length(e),abs(e(2:length(e))))    
    


    