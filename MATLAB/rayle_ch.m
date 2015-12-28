function ber=rayle_ch(N,snr)
x=randerr(1,N,N/2) ;
ts=4;%Symbol period
cost=cos(pi*[-ts:N*ts-1]/(2*ts)); 
sint=sin(pi*[-ts:N*ts-1]/(2*ts));

%BPSK modulation
for i=1:N
    if(x(i)==0)
        mod(i)=-1;
    else
        mod(i)=1;
    end
end
temp=0;
b=ones(1,2*ts);

%Sending even and odd bits over 2*ts symbol period
for p=1:2:N
    for q=1:length(b)
        temp=temp+1;
        modev(temp)=mod(p)*b(q);
    end
end
temp=0;
for r=2:2:N
    for s=1:length(b)
        temp=temp+1;
        modod(temp)=mod(r)*b(s);
    end
end

modev=[modev zeros(1,ts)];
modod=[zeros(1,ts) modod]; %delaying odd samples by period ts
xt = 1/sqrt(ts)*[modev.*cost + j*modod.*sint];
nt = 1/sqrt(2)*[randn(1,N*ts+ts) + j*randn(1,N*ts+ts)]; 
x1=randn(1,N*ts+ts);
x2=randn(1,N*ts+ts);
rch=sqrt(x1.^2+x2.^2)
for sn=1:length(snr)
err=0;
yt = xt.*rch + 10^(-snr(sn)/20)*nt;

%Integrating even and odd samples on 0 to 2*ts
evrec=conv(real(yt).*cost,ones(1,2*ts)); 
odrec=conv(imag(yt).*sint,ones(1,2*ts));

%Recovering even and odd bits with hard decision decoding
oprec=zeros(1,N);
oprec(1:2:length(oprec))=evrec(2*ts+1:2*ts:end-2*ts)>0;
oprec(2:2:length(oprec))=odrec(3*ts+1:2*ts:end-ts)>0;

%Finding error 
for errec=1:length(oprec)
    if(oprec(errec)~=x(errec))
        err=err+1;
    end
end
ber(sn)=err/N;
end


