clc
clear all

delt=.1;
delw=.1;
t=-10:delt:10;
f=exp(1i.*.15.*t.^3);
N=628;
K=43;
p=1;
q=1;
f=[zeros(1,K) f zeros(1,K)];
n=K;
m=K;
for l=-5:delt:15
    for o=-10:delw:10
        k=n-K:n+K;
        X(p,q)=sum(exp(-1i.*(2.*pi./N).*m.*k).*(exp((((k-n).^2)./2).*delt.^2).*f(k+1)));    
        n=n+1;
        p=p+1;
        m=m+1;
        q=q+1;
    end
end


Y=delt*exp(1i*m*n*(pi/N))*X/sqrt(2*pi);

