close all
clear all
clc

disp('channel types are :- ');
disp('1.AWGN    2. RAYLEIGH     3. NAKAGAMI    4. RICIAN   ');
ch1=input('enter your choice = ');

disp(' The Convolution Coder types are ');
disp(' 1. (1/2) ');
ch= input(' Enter your choice = ');

disp(' The modulation types are ');
disp(' 1. M-psk  2. M-qam ');
chm= input(' Enter your choice = ');

%OFDM transmitter

[data_tx,hlen2,mift,hclen,m,sip1,ipMod_len,eop_len] = ofdmtxlkfn(ch1,ch,chm);
a=-1;
opfrft = frfttxlkfn(data_tx,a);
data_txfinal = opfrft; 

SNR1=0:5:100;
 for k=1:length(SNR1)
    snr=SNR1(k);

data_rx=channellkfn(data_txfinal',snr,ch1);
opfrft=frftrxlkfn(data_rx,-a);
if (mod(length(opfrft),2)==0)
    asd = rot90(opfrft);
fgh = rot90(asd);
for i= 1:length(data_tx)-1
    zxc(i) = fgh(i);
end
for j= 2:length(data_tx)
    opfrft(j) = zxc(j-1);
end
else
       opfrft1= opfrft';
 opfrft = rot90(opfrft1);
end
opfrft;

dec_op2=ofdmrxlkfn(chm,m,opfrft',hlen2,mift,hclen,ipMod_len,eop_len);
dec_oplen = length(dec_op2);
e=0;
for p=1:dec_oplen
    if(sip1(p)~=dec_op2(p))
        e=e+1;
    end
end
err(k)=e/dec_oplen;
 end
 format long
 err
 figure;semilogy(SNR1,err)
 grid on;
  axis ([-Inf Inf 10^(-3) 1])
  xlabel('signal to noise ratio')
 ylabel('bit error rate')
toc
