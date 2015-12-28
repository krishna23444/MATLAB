clc;

N = 37; 
n = -(N-1)/2 : 1 : (N - 1)/2;

wn_rect = ones(N,1);
wn_hanning = 0.5 + 0.5 * cos(2 * pi * n / N);
wn_hamming = 0.54 + 0.46 * cos(2 * pi * n / N);
wn_blackman = 0.42 + 0.5 * cos(2 * pi * n /(N - 1)) + 0.08 * cos(4 * pi * n /(N - 1));

wn_rect_f = 20 * log10( abs( fft(wn_rect,1024) / max(fft(wn_rect,1024)) ));
wn_hanning_f  = 20 * log10( abs( fft(wn_hanning,1024) / max(fft(wn_hanning,1024)) ));
wn_hamming_f = 20 * log10( abs( fft(wn_hamming,1024) / max(fft(wn_hamming,1024)) ));
wn_blackman_f = 20 * log10( abs( fft(wn_blackman,1024) / max(fft(wn_blackman,1024)) ));

plot(wn_rect,'-.');
axis([0 N 0 1.25]);

hold on

plot(wn_hanning,'--');

plot(wn_hamming,'-.');

plot(wn_blackman,'black');

hold off

legend('Rectangular','Hanning','Hamming','Blackman',4);

figure;

subplot(2,2,1);
plot(wn_rect_f);
xlim([0 1024]);
title('Rectangular','FONTSIZE',14);
ylabel('|W(f)|, db','FONTSIZE',12);

subplot(2,2,2);
plot(wn_hanning_f);
xlim([0 1024]);
title('Hanning','FONTSIZE',14);
ylabel('|W(f)|, db','FONTSIZE',12);

subplot(2,2,3);
plot(wn_hamming_f);
xlim([0 1024]);
title('Hamming','FONTSIZE',14);
ylabel('|W(f)|, db','FONTSIZE',12);

subplot(2,2,4);
plot(wn_blackman_f);
xlim([0 1024]);
title('Blackman','FONTSIZE',14);
ylabel('|W(f)|, db','FONTSIZE',12);