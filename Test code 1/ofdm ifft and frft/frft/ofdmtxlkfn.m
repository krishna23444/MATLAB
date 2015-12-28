function [data_tx,hlen2,mift,hclen,m,sip1,ipMod_len,eop_len] = mimoofdmtxlkfn(ch1,ch,chm)

%SOURCE DATA GENERATION

nip=50;
aip=randint(nip);
gip=reshape(aip,1,nip*nip);
for m=1:2400
    sip1(m)=gip(m);
end
sip1;
dip=rot90(sip1);

%CODING

eop=convcoderlkfn(dip,ch);
eop_len=length(eop);
eop=[eop zeros(1,100)];

%INTERLEAVING

row=70;
col=70;
counter=1;
for j=1:col
    for i=1:row
     M(i,j)=eop(counter);
     counter=counter+1;
    end
end
M;
counter1 = 1;
for i=1:row
   for j=1:col
      yopi(counter1) = M(i,j);
      counter1 = counter1 + 1;
   end
end
yopi;
yopi_len=length(yopi);


%MODULATION

[ipMod,m] = modulationlkfn(yopi,chm);                            
ipMod;
ipMod_len=length(ipMod);
% scatterplot(ipMod)
nlen_sp=length(ipMod);
mlen_sp=length(ipMod);
 if mod(nlen_sp,96)==0
                len_sp=nlen_sp;
            else
               while mod(mlen_sp,96)~=0
                   
                mlen_sp=mlen_sp+1;
              len_sp=mlen_sp;
               end
 end
 ipMod1=[ipMod zeros(1,len_sp-nlen_sp)];
n2lenm=length(ipMod1);
mift=n2lenm/96;
ipMod2=reshape(ipMod1,96,mift);

%IFFT

c=mift;
for p=1:c
    ha=ipMod2(:,p);
haift=dcifftlkfn(ha);
opift(:,p)=haift;
end
lkiftop=opift;

%CYCLIC PREFIX

for i=1:mift
    hcy=lkiftop(:,i);
    hlen=length(hcy);
    hclen=ceil(hlen/4);
    hcy2=[hcy(hlen-hclen+1:hlen);hcy];
    hlen2=length(hcy2);
    hcyc(:,i)=hcy2;
end
hcyc;
hclen;
hlen2;

%PARALLEL TO SERIAL CONVERSION

n3lenm=mift*hlen2;
ipfinal=reshape(hcyc,1,n3lenm);
ipfinal;
data_tx=ipfinal;
data_txlen=length(data_tx);
end