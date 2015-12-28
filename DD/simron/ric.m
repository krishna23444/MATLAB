% Script for computing the BER for BPSK modulation in a
% Rician fading channel with nTx, nRx MIMO channel 
% Minimum Mean Square Error equalization
clc;
clear all;
N = 10000; % number of bits or symbols
Eb_N0_dB = [0:25]; % multiple Eb/N0 values
nTx = 2;
nRx = 2;
for ii = 1:length(Eb_N0_dB)

    % Transmitter
    ip = rand(1,N)>0.5; % generating 0,1 with equal probability
    s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0
    sMod = kron(s,ones(nRx,1)); % 
    sMod = reshape(sMod,[nRx,nTx,N/nTx]); % grouping in [nRx,nTx,N/NTx ] matrix
 for m=1:nRx
     for  n=1:nTx
     for i=1:N/nTx
if m<=n
R(m,n,i)=0.7^(n-m);
else
R(m,n,i)=R(n,m,i);
end
 end
    end
end
K=1;
Rr=R.^(1/2);
Rt=R.^(1/2);
Hi=eye(nTx,nRx);
    w = (sqrt(1/K+1))*1/sqrt(2)*[randn(nRx,nTx,N/nTx) + j*randn(nRx,nTx,N/nTx)]; % Rayleigh channel
    H=  sqrt(K/K+1)*(Rr.*Rt);
    
        h=w.*H;
     n = 1/sqrt(2)*[randn(nRx,N/nTx) + j*randn(nRx,N/nTx)]; % white gaussian noise, 0dB variance

    % Channel and noise Noise addition
    y = squeeze(sum(h.*sMod,2));

    for k=1:N/nTx
%     for m=1:N/nTx
    hn=h(:,:,k);
     dum=hn(1,2);hn(1,2)=hn(2,1);hn(2,1)=dum;
    hm(:,:,k) = hn*hn'     +10^(-Eb_N0_dB(ii)/10)*eye(2);
    hl(:,:,k)=inv(hm(:,:,k));
%     hz = hl;
%     for xx=1:nRx
%     hl(xx,xx,k)=hl(xx,xx,k);
%     end
%     end
    
    end

 hMod =  reshape(conj(h),nRx,N); % H^H operation   
    yMod = kron(y,ones(1,nRx)); % formatting the received symbol for equalization
   yMod1 = sum(hMod.*yMod,1); % H^H * y 
    yMod2 =  kron(reshape(yMod1,nRx,N/nTx),ones(1,nRx)); % formatting
     yHat = sum(reshape(hl,nRx,N).*yMod2,1); % inv(H^H*H)*H^H*y
   
    % receiver - hard decision decoding
    ipHat = real(yHat)>0;

    % counting the errors
  
    nErr(ii) = size(find([ip- ipHat]),2)
  end
% Receiver
 simBer = nErr/N % simulated ber
 EbN0Lin = 10.^(Eb_N0_dB/10);
theoryBer_nRx1 = 0.5.*(1-1*(1+1./EbN0Lin).^(-0.5)); 
p = 1/2 - 1/2*(1+1./EbN0Lin).^(-1/2);
theoryBerMRC_nRx2 = p.^2.*(1+2*(1-p)); 
  
close all
figure
semilogy(Eb_N0_dB,theoryBer_nRx1,'bp-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,theoryBerMRC_nRx2,'kd-','LineWidth',2);
semilogy(Eb_N0_dB,simBer,'mo-','LineWidth',2);
axis([0 25 10^-5 0.5])
grid on
legend('theory (nTx=2,nRx=2, ZF)', 'theory (nTx=1,nRx=2, MRC)', 'sim (nTx=2, nRx=2, MMSE)');
xlabel('Average Eb/No,dB');
ylabel('Bit Error Rate');
title('BER for BPSK modulation with 2x2 MIMO and MMSE equalizer (Rician channel)');