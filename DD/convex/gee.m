function y=gee(mm,dd,N,sig)

for m=1:N+1
    for k=1:N+1
        phi(m,k)=radb(abs((k-1)-(m-1)),sig);
    end
end

alp=inv(phi);

s=0;
for kk=0:N
    s=s+alp(kk+1,mm+1)*radb(abs(kk-dd),sig);
end
y=s;

        