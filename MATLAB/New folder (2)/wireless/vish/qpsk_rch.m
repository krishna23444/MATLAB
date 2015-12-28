clc
clear all
close all

%Input Data
Nbit=input('Enter the no. of bits to transmit')
x=randerr(1,Nbit,Nbit/2);

a=1;
for b=1:2:length(x)
    for c=1:2
        y(c)=x(b);
        b=b+1;
    end
    op=bintdec(y);
    xop(a)=op;
    a=a+1;
end  
for d=1:length(xop)
    x_mod(d)=exp(-j*pi*xop(d)/2);
end
r=0:3;
cons=exp(-j*pi*r/2);
rch=sqrt(-log(randn(1,length(x_mod)))); %Rayleigh Channel
n=randn(1,length(x_mod));  %Random Noise
snr=-5:30;
for e=1:length(snr)
    err=0;
    x_ch=x_mod.*rch+10^(-snr(e)/20)*n;  %AWGN Channel
    x_eq=x_ch./rch;
    for f=1:length(x_ch)
        [no place]=min(abs(x_eq(f)-cons)); %Find Minimum Distance
        oprec1(f)=place-1;
    end
    oprec=dec2bin(oprec1,2);
    [row col]=size(oprec);
    coun=1;
    for acl=1:row
        for bcl=1:col
            opact(coun)=oprec(acl,bcl);
            coun=coun+1;
        end
    end
    for conl=1:length(opact)
        x_demod(conl)=str2num(opact(conl)); %Demodulated Data
    end
    
    %Error Calculation
    chk_eq=(x_demod==x);
    n_err=sum(chk_eq==0);
    ber(e)=n_err/Nbit;
end
semilogy(snr,ber,'Linewidth',2)
xlabel('Signal To Noise Ratio(SNR)')
ylabel('Bit Error Rate(BER)')
title('BER vs SNR plot for QPSK modulation with Rayleigh Fading Channel')
grid on
    