clear all
close all
clc
Nbit=input('Enter the no. of bits to transmit');
x=randerr(1,Nbit,Nbit/2) ; %Input Sequence
x_mod=2*x-1; %BPSK Modulation
snr=-5;
for n_rec=1:20
    noi=randn(n_rec,length(x_mod));
    rch=sqrt(-log(noi));
    m=ones(n_rec,1)*x_mod;
    op=rch.*m+10^(-snr/20)*noi;
    oprec=sum(conj(rch).*op,1);
    op_snr(n_rec)=mean(abs(oprec));
end
plot(1:20,10*log10(op_snr),'Linewidth',2)
xlabel('No. of Receiver Antenna')
ylabel('Output SNR')
title('Output SNR vs No. of Receiver Antenna with Maximal Ratio Combining')
grid on            