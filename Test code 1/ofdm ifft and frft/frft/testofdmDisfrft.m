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

tic

%OFDM transmitter

[data_ip,hlen2,mift,hclen,m,sip1,ipMod_len,eop_len] = ofdmtxlkfn(ch1,ch,chm);

for f=1:11
a=0:.1:1;
data_tx = Disfrft(data_ip,a(f));
 

SNR1=0:5:100;
 for k=1:length(SNR1)
    snr=SNR1(k);

data_rx=channellkfn(data_tx',snr,ch1);
data_op= Disfrft(data_rx',-a(f));
data_opfinal=conj(data_op);
dec_op2=ofdmrxlkfn(chm,m,data_opfinal',hlen2,mift,hclen,ipMod_len,eop_len);
dec_oplen = length(dec_op2);
e=0;
for p=1:dec_oplen
    if(sip1(p)~=dec_op2(p))
        e=e+1;
    end
end
err(k)=e/dec_oplen;
 end
 err_final(f,:) =err;
 mmse(f,:)=err.^2;
end
 format long
 
 figure;semilogy(SNR1,err_final(1,:),SNR1,err_final(2,:),SNR1,err_final(3,:),SNR1,err_final(4,:),SNR1,err_final(5,:),SNR1,err_final(6,:),SNR1,err_final(7,:),SNR1,err_final(8,:),'o-',SNR1,err_final(9,:),'*-',SNR1,err_final(10,:),'x-',SNR1,err_final(11,:),'+-')
  grid on;
  axis ([-Inf Inf 10^(-3) 1])
  xlabel('signal to noise ratio')
 ylabel('bit error rate')
 title('plot for 256-QAM in AWGN channel')
 legend('a=0','a=.1','a=.2','a=.3','a=.4','a=.5','a=.6','a=.7','a=.8','a=.9','a=1')
%  figure;plot(SNR1,mmse(1,:),SNR1,mmse(2,:),SNR1,mmse(3,:),SNR1,mmse(4,:),SNR1,mmse(5,:),SNR1,mmse(6,:),SNR1,mmse(7,:),SNR1,mmse(8,:),'o-',SNR1,mmse(9,:),'*-',SNR1,mmse(10,:),'x-',SNR1,mmse(11,:),'+-')

toc
