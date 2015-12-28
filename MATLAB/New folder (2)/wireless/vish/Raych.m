function ber=Raych(Nbit,M,snr)
x=randerr(1,Nbit,ceil(Nbit/2)) ;
m=log2(M);
remain=mod(length(x),m);
if(remain~=0)
xnew=[x,zeros(1,m-remain)];
else
    xnew=x;
end
t=1;
for u=1:m:length(xnew)
    for v=1:m
        y(v)=xnew(u);
        u=u+1;
    end
    op=bintdec(y);
    xop(t)=op;
    t=t+1;
end  
for k=1:length(xop)
    fop(k)=exp(-j*2*pi*xop(k)*(M-1)/M);
end
p=0:M-1;
cons=exp(2*pi*p*(M-1)/M*(-j));
rch=sqrt(-log(randn(1,length(fop))));
noi=randn(1,length(fop));
for w=1:length(snr)
err=0;
nch=fop.*rch+10^(-snr(w)/20)*noi;
x_eq=nch./rch;
for rop=1:length(nch)
    [no place]=min(abs(x_eq(rop)-cons));
    oprec1(rop)=place-1;
end
oprec=dec2bin(oprec1,m);
[row col]=size(oprec);
coun=1;
for acl=1:row
    for bcl=1:col
    opact(coun)=oprec(acl,bcl);
    coun=coun+1;
    end
end
for conl=1:length(opact)
    x_demod(conl)=str2num(opact(conl)); %Demodulated Data
end
 for blop=1:length(x)
     if(x_demod(blop)~=x(blop))
         err=err+1;
     end
 end
 ber(w)=err/Nbit;
end











