clear all
close all
clc
N=input('Enter the no. of bits to transmit');
snr=0:10;
ber1=msk(N,snr);
ber2=rayle_ch(N,snr);

semilogy(snr,ber1,snr,ber2)
legend('AWGN','Rayleigh')
xlabel('SNR')
ylabel('BER')
title('Bit Error Rate vs SNR plot')
grid on
