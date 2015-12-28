clc;
clear;

N = 10^6;              % Number of symbols to transmit.
SNR_dB = -3:10;        % SNR in dB.

%% Generate random symbols and modulate using QPSK.

DataBit1_Tx = rand(1,N) > 0.5;     % Generate N random 0's and 1's.
DataBit2_Tx = rand(1,N) > 0.5;     % Generate N random 0's and 1's.
QPSKSym1_Tx = 2*DataBit1_Tx - 1;   % Modulate using BPSK ( -1 for 0 and 1 for 1 ). 
QPSKSym2_Tx = 2*DataBit2_Tx - 1;   % Modulate using BPSK ( -1 for 0 and 1 for 1 ). 

%% Draw Constellation for Tx.

dataIndicesX = zeros(1,4);
dataIndicesY = zeros(1,4);

n = find(DataBit1_Tx == 0 & DataBit2_Tx == 0);
dataIndicesX(1) = n(1);
dataIndicesY(1) = n(1);

n = find(DataBit1_Tx == 0 & DataBit2_Tx == 1);
dataIndicesX(2) = n(1);
dataIndicesY(2) = n(1);

n = find(DataBit1_Tx == 1 & DataBit2_Tx == 0);
dataIndicesX(3) = n(1);
dataIndicesY(3) = n(1);

n = find(DataBit1_Tx == 1 & DataBit2_Tx == 1);
dataIndicesX(4) = n(1);
dataIndicesY(4) = n(1);

dataValuesX = zeros(1,4);
dataValuesY = zeros(1,4);

for n = 1:4
    dataValuesX(n) = QPSKSym1_Tx(dataIndicesX(n));
    dataValuesY(n) = QPSKSym2_Tx(dataIndicesX(n));
end

h = stem(dataValuesX ,dataValuesY);
title('Constellation -> (Tx - Red) : (Rx - Green)');
set(h,'LineStyle','none');
set(h,'Marker','square');
set(h,'MarkerFaceColor','red');
baseline_handle = get(h,'BaseLine');
set(baseline_handle,'LineWidth',3)

line([0 0], [-2 2], 'LineWidth',3, 'Color' , 'k');

axis([-2 2 -2 2])
grid on;

%% Receive signal, demodulate and find BER.
     
BER_Bit1 = zeros(1,length(SNR_dB));
BER_Bit2 = zeros(1,length(SNR_dB));
BER = zeros(1,length(SNR_dB));

% Gaussian Noise with 0dB variance.
GN = 1/sqrt(2) * (randn(1,N) + 1i*randn(1,N));
 
for n = 1 : length(SNR_dB)
   
    AWGN = 1 / 10^(SNR_dB(n)/20) * GN;
    
    % Received Signal.
    QPSKSym1_Rx = QPSKSym1_Tx + AWGN;
    QPSKSym2_Rx = QPSKSym2_Tx + AWGN;

    % Demodulated signal.
    DataBit1_Rx = real(QPSKSym1_Rx) > 0;
    DataBit1_Rx(DataBit1_Rx <= 0) = 0;
    DataBit1_Rx(DataBit1_Rx > 0) = 1;
  
    DataBit2_Rx = real(QPSKSym2_Rx) > 0;
    DataBit2_Rx(DataBit2_Rx <= 0) = 0;
    DataBit2_Rx(DataBit2_Rx > 0) = 1;
  
    % Count Error Bits.
    Error_Bits = (DataBit1_Tx - DataBit1_Rx) | (DataBit2_Tx - DataBit2_Rx);
   
    BER(n) = length(find(Error_Bits)) / N;
        
end

%% Draw Constellation for Rx.

hold on

for n = 1:4
    dataValuesX(n) = QPSKSym1_Rx(dataIndicesX(n));
    dataValuesY(n) = QPSKSym2_Rx(dataIndicesX(n));
end

h = stem(dataValuesX ,dataValuesY);
set(h,'LineStyle','none');
set(h,'Marker','square');
set(h,'MarkerFaceColor','green');

Xd = get(h, 'XData');
Yd = get(h, 'YData');

for K = 1 : length(Xd)
   text(Xd(K), Yd(K) * 1.1, ['( ' num2str(Xd(K)) ' , ' num2str(Yd(K)) ' )'] , 'HorizontalAlignment', 'center');
end

hold off

%% Draw BER.

figure;
semilogy(SNR_dB,BER);
axis([-3 10 10^-5 0.5])
grid on
xlabel('SNR, dB');
ylabel('BER');
title('Error Probability (QPSK)');
