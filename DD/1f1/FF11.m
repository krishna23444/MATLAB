function V=FF11(a,b,N,u,phi)
if a==0
    V=1;
else
    syms x;
    h=hypergeom(a,b,x);
    t=taylor(h,N);
    x=-1i*(u^2)*csc(2*phi);
    V=subs(t);
end


    


    


    