clear all
close all
clc
Nbit=input('Enter the no. of bits to transmit');
x=randerr(1,Nbit,Nbit/2) ; 
x_mod=2*x-1; 
snr=10;
for numantenna=1:20
    noi=randn(numantenna,length(x_mod));
    rch=sqrt(-log(noi));
    m=ones(numantenna,1)*x_mod;
    op=rch.*m+10^(-snr/20)*noi;
    outputrx=sum(conj(rch).*op,1);
    output_snr(numantenna)=mean(abs(outputrx));
end
plot(1:20,10*log10(output_snr),'Linewidth',2)
grid on    