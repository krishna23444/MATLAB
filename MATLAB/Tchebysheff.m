clc
clear all
n=input('enter n')
s=input('enter s')
r=10^(s/20);
an=.5*(((r+sqrt(r^2-1))^(1/(n-1))) + ((r-sqrt(r^2-1))^(1/(n-1))));
syms a;
tp=chb(n-1);
A(1)=(an)^(n-1);
if mod(n,2)==0
    for i=1:n/2
        o(i)=chb(2*i-1);
        o(i)=subs(o(i),a/an);
        U(i,:)=[zeros(1,(n-length(sym2poly(o(i))))) sym2poly(o(i))];
    end
else
    for i=1:((n-1)/2)+1
        o(i)=chb(2*(i-1));
        o(i)=subs(o(i),a/an);
        U(i,:)=[zeros(1,(n-length(sym2poly(o(i))))) sym2poly(o(i)) ];
    end
end

tpp=sym2poly(tp);
tpp=tpp(1:2:n);
U=U(:,1:2:n);
U(ceil(n/2),:)=A(1)*U(ceil(n/2),:);

for i=2:ceil(n/2)
     
 A(i)=(tpp(i)-sum(U(ceil(n/2)-i+2:ceil(n/2),i:i)))/U(ceil(n/2)-(i-1),i)    ;
 U(ceil(n/2)-i+1,:)=A(i)*U(ceil(n/2)-i+1,:);
 end
 A=A/min(A)

