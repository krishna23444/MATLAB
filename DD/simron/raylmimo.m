clc;
clear all;
N = 1000; % number of bits or symbols
Eb_N0_dB = [0:25]; % multiple Eb/N0 values
nTx = 2;
nRx = 2;
for ii = 1:length(Eb_N0_dB)

    % Transmitter
    ip = rand(1,N)>0.5; % generating 0,1 with equal probability
    s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0

    sMod = kron(s,ones(nRx,1)); % 
    sMod = reshape(sMod,[nRx,nTx,N/nTx]); % grouping in [nRx,nTx,N/NTx ] matrix

%     h = 1/sqrt(2)*[randn(nRx,nTx,N/nTx) + j*randn(nRx,nTx,N/nTx)]; % Rayleigh channfor m=1:nRx
     
for  m=1:nRx
 for n=1:nTx
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
    w = (sqrt(1/K+1))*1/sqrt(2)*[randn(nRx,nTx,N/nTx) + j*randn(nRx,nTx,N/nTx)]; % Rayleigh channel
    H=  sqrt(K/K+1)*(Rr.*Rt);
    
        h=w.*H;
     n = 1/sqrt(2)*[randn(nRx,N/nTx) + j*randn(nRx,N/nTx)]; % white gaussian noise, 0dB varianceel
    n = 1/sqrt(2)*[randn(nRx,N/nTx) + j*randn(nRx,N/nTx)]; % white gaussian noise, 0dB variance

    % Channel and noise Noise addition
    y = squeeze(sum(h.*sMod,2)) + 10^(-Eb_N0_dB(ii)/20)*n;

    % Receiver

    % Forming the MMSE equalization matrix W = inv(H^H*H+sigma^2*I)*H^H
    % H^H*H is of dimension [nTx x nTx]. In this case [2 x 2] 
    % Inverse of a [2x2] matrix [a b; c d] = 1/(ad-bc)[d -b;-c a]
     hCof = zeros(2,2,N/nTx)  ; 
    hCof(1,1,:) = sum(h(:,2,:).*conj(h(:,2,:)),1)     + 10^(-Eb_N0_dB(ii)/10);  % d term
    hCof(2,2,:) = sum(h(:,1,:).*conj(h(:,1,:)),1)     + 10^(-Eb_N0_dB(ii)/10);  % a term
    hCof(2,1,:) = -sum(h(:,2,:).*conj(h(:,1,:)),1); % c term
    hCof(1,2,:) = -sum(h(:,1,:).*conj(h(:,2,:)),1); % b term
    hDen = ((hCof(1,1,:).*hCof(2,2,:)) - (hCof(1,2,:).*hCof(2,1,:))); % ad-bc term
    hDen = reshape(kron(reshape(hDen,1,N/nTx),ones(2,2)),2,2,N/nTx);  % formatting for division
    hInv1 = hCof./hDen; % inv(H^H*H)
  for k=1:N/nTx
%     for m=1:N/nTx
     hn=h(:,:,k);
     dum=hn(1,2);hn(1,2)=hn(2,1);hn(2,1)=dum;
    hm(:,:,k) = hn*hn'     +10^(-Eb_N0_dB(ii)/10)*eye(2);
    hInv(:,:,k)=inv(hm(:,:,k));
%     hz = hl;
%     for xx=1:nRx
%     hl(xx,xx,k)=hl(xx,xx,k);
%     end
%     end
    
    end
    hMod =  reshape(conj(h),nRx,N); % H^H operation
    
    yMod2 = kron(y,ones(1,2)); % formatting the received symbol for equalization
    yMod1 = sum(hMod.*yMod2,1); % H^H * y 
    yMod =  kron(reshape(yMod1,2,N/nTx),ones(1,2)); % formatting
    yHat = sum(reshape(hInv,2,N).*yMod,1); % inv(H^H*H)*H^H*y
   
    % receiver - hard decision decoding
    ipHat = real(yHat)>0;

    % counting the errors
    nErr(ii) = size(find([ip- ipHat]),2);

end

simBer = nErr/N; % simulated ber
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
title('BER for BPSK modulation with 2x2 MIMO and MMSE equalizer (Rayleigh channel)');
