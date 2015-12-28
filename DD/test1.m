% Example of lpdiff

K = 6;
N = 29;
h = lpdiff(K,N);
n = 0:N-1;
[H,w] = freqz(h);

figure(1)
clf
subplot(2,1,1)
stem(n,h,'.')
title('IMPULSE RESPONSE')
subplot(2,1,2);
plot(w/pi,abs(H));
xlabel('\omega/\pi')
title('FREQUENCY RESPONSE')

figure(2)
clf
zplane(h);
title('ZERO DIAGRAM')
