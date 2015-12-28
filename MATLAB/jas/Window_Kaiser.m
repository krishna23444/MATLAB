clc;
clear;

N = 53;

BETA = 5.44;

k = 1 : 1 : 20;
I_0_BETA = zeros(1,N);
count = 1;
for n = -(N-1)/2 : 1 : (N - 1)/2
    I_0_BETA(count) = 1 + sum (((((BETA .* sqrt(  1 - (2*n ./ (N-1)).^2 )) /2).^k) ./ factorial(k)).^2);
    count = count + 1;
end

I_BETA = 1 + sum((((BETA/2).^k)./factorial(k)).^2);

wn_kaiser = I_0_BETA / I_BETA;

wn_kaiser_f = 20 * log10( abs( fft(wn_kaiser,1024) / max(fft(wn_kaiser,1024)) ));

plot(wn_kaiser,'k');
axis([0 N 0 1.25]);
title('Kaiser Window for \beta = 5.44','FONTSIZE',14);
 
figure;

plot(wn_kaiser_f,'k');
xlim([0 1024]);
title('Kaiser Window for \beta = 5.44','FONTSIZE',14);
ylabel('|W(f)|, db','FONTSIZE',12);
