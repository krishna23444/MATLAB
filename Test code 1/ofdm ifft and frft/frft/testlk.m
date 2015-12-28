close all
clear all
clc

disp('channel types are :- ');
disp('1.AWGN    2. RAYLEIGH     3. NAKAGAMI    4. RICIAN   ');
ch1=input('enter your choice = ');

disp(' The Convolution Coder types are ');
disp(' 1. (1/2) ');
% 2. (2/3)     3. (3/4)
ch= input(' Enter your choice = ');

disp(' The modulation types are ');
disp(' 1. M-psk  2. M-qam ');
chm= input(' Enter your choice = ');
tic
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
% scatterplot(data_tx)

%CHANNEL
 
SNR1=0:5:100;
 for p=1:length(SNR1)
    snr=SNR1(p);

data_rx=channellkfn(data_tx,snr,ch1);
    

%RECEIVAR SIDE

%SERIAL TO PARALLEL CONVERSION 

data_serial=reshape(data_rx,hlen2,mift);

%CYCLIC PREFIX REMOVAL

for i=1:mift
data_cyclic=data_serial(:,i);
for j=hclen+1:hlen2
data_cycoutput(j-hclen)=data_cyclic(j);
end
g=length(data_cycoutput);
data_cyclicoutput(:,i)=data_cycoutput;
end
data_cyclicop=data_cyclicoutput;
size(data_cyclicop);
%FFT

ipDemod=reshape(data_cyclicop,96,mift);
for v=1:c
    hs=ipDemod(:,v);
    hsft=dclkfn(hs);
opft(:,v)=hsft;
end
opft1=reshape(opft,1,mift*96);
for t=1:ipMod_len
    ipfinal(t)=opft(t);
end
ipfinal;


%DEMODULATION

if (chm==1)
     chdm=1;
else
    chdm=2;
 end
data_demod=demodulationlkfn(ipfinal,chdm,m);

%DENTERLEAVING

ipfinal_len=length(ipfinal);
counter2=1;
for j=1:col
    for i=1:row
     N(i,j)=data_demod(counter2);
     counter2=counter2+1;
    end
end
N;
counter4 = 1;
for i=1:row
   for j=1:col
      dopi(counter4) = N(i,j);
      counter4 = counter4 + 1;
   end
end
dopi;

%DECODING

for i=1:eop_len
    dop_op(i)=dopi(i);
end
dec_op=viterbidec(dop_op);
dec_op1=rot90(dec_op);
dec_op2=rot90(dec_op1);
dec_oplen=length(dec_op);

%ERROR CALCULATION

e=0;
for i=1:dec_oplen
    if(sip1(i)~=dec_op2(i))
        e=e+1;
    end
end
err(p)=e/dec_oplen;
 end
 format long
 err
 figure;semilogy(SNR1,err)
 grid on;
  axis ([-Inf Inf 10^(-4) 1])
  xlabel('signal to noise ratio')
 ylabel('bit error rate')
toc


