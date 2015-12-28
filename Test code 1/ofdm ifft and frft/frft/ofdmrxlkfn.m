function [dec_op2,dec_oplen] = mimoofdmrxlkfn(chm,m,data_rxip,hlen2,mift,hclen,ipMod_len,eop_len)

%RECEIVAR SIDE

%SERIAL TO PARALLEL CONVERSION 

data_serial=reshape(data_rxip,hlen2,mift);

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

%FFT
c=mift;
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
% scatterplot(ipfinal)

%DEMODULATION

if (chm==1)
     chdm=1;
else
    chdm=2;
 end
data_demod=demodulationlkfn(ipfinal,chdm,m);
%scatterplot(data_demod)

%DENTERLEAVING
col=70;
row=70;
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
end
