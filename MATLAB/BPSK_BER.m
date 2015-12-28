clc;
clear;

N = 10^6;              % Number of symbols to transmit.
SNR_dB = -3:10;        % SNR in dB.

%% Generate random symbols and modulate using BPSK.

Data_Tx = rand(1,N) > 0.5;     % Generate N random 0's and 1's.
BPSK_Tx = 2*Data_Tx - 1;       % Modulate using BPSK ( -1 for 0 and 1 for 1 ). 

%% Draw Constellation for Tx.

dataIndicesX = zeros(1,2);

n = find(Data_Tx == 0);
dataIndices(1) = n(1);

n = find(Data_Tx == 1);
dataIndices(2) = n(1);

dataValues = zeros(1,2);

for n = 1:2
    dataValues(n) = BPSK_Tx(dataIndices(n));
end

h = stem(dataValues,[0 0]);
title('Constellation -> (Tx - Red) : (Rx - Green)');
set(h,'LineStyle','none');
set(h,'Marker','square');
set(h,'MarkerFaceColor','red');

set(h,'BaseValue',-2);
line([0 0], [-2 2], 'LineWidth',3, 'Color' , 'k');

axis([-2 2 -1 1]);
grid on;

%% Receive signal, demodulate and find BER.
     
BER = zeros(1,length(SNR_dB));

% Gaussian Noise with 0dB variance.
GN = 1/sqrt(2) * (randn(1,N) + 1i*randn(1,N));
 
for n = 1 : length(SNR_dB)
   
    AWGN = 1 / 10^(SNR_dB(n)/20) * GN;
    
    % Received Signal.
    BPSK_Rx = BPSK_Tx + AWGN;

    % Demodulated signal.
    Data_Rx = real(BPSK_Rx) > 0;
    Data_Rx(Data_Rx <= 0) = 0;
    Data_Rx(Data_Rx > 0) = 1;
  
    % Count Error Bits.
    Error_Bits = Data_Tx - Data_Rx;
    BER(n) = length(find(Error_Bits)) / N;

end

%% Draw Constellation for Rx.

hold on

for n = 1:2
    dataValues(n) = BPSK_Rx(dataIndices(n));
end

h = stem(dataValues,[0 0]);
set(h,'LineStyle','none');
set(h,'Marker','square');
set(h,'MarkerFaceColor','green');

Xd = get(h, 'XData');
Yd = get(h, 'YData');

for K = 1 : length(Xd)
    text(Xd(K), -0.1, ['( ' num2str(Xd(K)) ' , ' num2str(Yd(K)) ' )'] , 'HorizontalAlignment', 'center');
end

hold off

%% Draw BER.

figure;
semilogy(SNR_dB,BER);
axis([-3 10 10^-5 0.5])
grid on
xlabel('SNR, dB');
ylabel('BER');
title('Error Probability (BPSK)');