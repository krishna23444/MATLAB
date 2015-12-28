clc
clear all
close all
%Input Data
Nbit=input('Enter the no. of bits to transmit')
x=randerr(1,Nbit,Nbit/2);

%BPSK Modulation
x_mod=2*x-1;
snr=-5:30;
rch=sqrt(-log(randn(1,length(x_mod))));
noi=randn(1,length(x_mod));
%Demodulation with Bit Error Rate Calculation
for m=1:length(snr)
    err=0;
    x_ch=rch.*x_mod+10^(-snr(m)/20)*noi; %Rayleigh Channel
    x_eq=x_ch./rch; 
    for k=1:length(x_eq)
        if(x_eq(k)>0)
            x_demod(k)=1;
        else
            x_demod(k)=0;
        end
    end
    for l=1:length(x_demod)
        if(x_demod(l)~=x(l))
            err=err+1;
        end
    end
    ber(m)=err/Nbit;
end
semilogy(snr,ber,'Linewidth',2)
xlabel('Signal To Noise Ratio(SNR)')
ylabel('Bit Error Rate(BER)')
title('BER vs SNR plot for BPSK modulation with Rayleigh Fading Channel')
grid on