clear all
close all
clc
Nbit=input('Enter the no. of bits to transmit');
snr=-5:10;
ber1=Bit_err(Nbit,8,snr);
ber2=Bit_err(Nbit,16,snr);
ber3=Bit_err(Nbit,32,snr);
semilogy(snr,ber1,snr,ber2,snr,ber3,'Linewidth',2)
legend('8-PSK','16-PSK','32-PSK')
xlabel('Signal To Noise Ratio(SNR)')
ylabel('Bit Error Rate(BER)')
title('BER vs SNR plot for M-PSK modulation with Rayleigh Fading Channel')
grid on