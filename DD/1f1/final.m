clc
clear all
close all
format long G

syms phi u
N=5;
mu=.5;

X=sqrt(1+1i*tan(phi)*exp(-1i*pi*(u^2)*tan(phi)));

y=sqrt((1-1i*cot(phi))/2*pi);
q=pi*(1i^mu)*(1+1i)^(1-mu)/(cot(phi)^((1-mu)/2));
p=1i*(1+1i)*sqrt(2*csc(2*phi))/gamma(mu/2);


   V = y*q*(1/gamma((1+mu))/2)*FF11((1-mu)/2,1/2,N,u,phi)*(X*1i*u*sin(phi)+cos(phi)*diff(X,u))...
      +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*diff(X,u))*FF11((2-mu)/2,3/2,N,u,phi)...
      +y*p*q*cos(phi)*FF11((2-mu)/2,3/2,N,u,phi)*X...
      +y*q*FF11((3-mu)/2,3/2,N,u,phi)*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
      +y*p*q*cos(phi)*FF11((4-mu)/2,5/2,N,u,phi)*u*X*((2-mu)/3);
  
  
   Vd = y*q*(1/gamma((1+mu))/2)*hypergeom((1-mu)/2,1/2,-1i*(u^2)*csc(2*phi))*(X*1i*u*sin(phi)+cos(phi)*diff(X,u))...
       +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*diff(X,u))*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))...
       +y*p*q*cos(phi)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X...
       +y*q*hypergeom((3-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
       +y*p*q*cos(phi)*hypergeom((4-mu)/2,5/2,-1i*(u^2)*csc(2*phi))*u*X*((2-mu)/3);
   
   q=1;
   for phi=0.1*pi:.1:.4*pi
      
     
      for u=0:.1:1
        Vd=subs(Vd);
        V=subs(V);
      RE(q)=real(Vd-V);
      IE(q)=imag(Vd-V);
      q=q+1;
      end
  
  
      
      
   end
  
  Re=double(RE)
  Ie=double(IE)
      
      