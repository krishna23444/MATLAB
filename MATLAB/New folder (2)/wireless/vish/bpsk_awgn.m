function ber=bpsk_awgn(Nbit,snr)

%Input Data
x=randerr(1,Nbit,Nbit/2);

%BPSK Modulation
x_mod=2*x-1;
n=randn(1,length(x_mod));  %Random Noise
snr=-5:10;

%Demodulation with Bit Error Rate Calculation
for j=1:length(snr)
    err=0;
    x_ch=x_mod+10^(-snr(j)/20)*n;  %AWGN Channel
    for k=1:length(x_ch)
        if(x_ch(k)>0)
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
    ber(j)=err/Nbit;
end
semilogy(snr,ber)
xlabel('Signal To Noise Ratio(SNR)')
ylabel('Bit Error Rate(BER)')
title('BER vs SNR plot for BPSK modulation with AWGN Channel')
grid on