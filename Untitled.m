plot(ecg(500)); %plot ECG signal
axis([0 500 -1.25 1.25]);
rng default;
x=ecg(500)'+0.25*randn(500,1); %noisy waveform
h=fdesign.lowpass('Fp,Fst,Ap,Ast',0.15,0.2,1,60);
d=design(h,'equiripple'); %Lowpass FIR filter
y=filtfilt(d.Numerator,1,x); %zero-phase filtering
y1=filter(d.Numerator,1,x); %conventional filtering
subplot(211);
plot([y y1]);
title('Filtered Waveforms');
legend('Zero-phase Filtering','Conventional Filtering');
subplot(212);
plot(ecg(500));
title('Original Waveform');


d1 = design(h,'butter');
y = filtfilt(d1.sosMatrix,d1.ScaleValues,x);
plot(x,'b-.');
hold on;
plot(y,'r','linewidth',3);
legend('Noisy ECG','Zero-phase Filtering','location','NorthEast');
whos
