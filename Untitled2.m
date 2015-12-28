Ts = 1e-6; % Symbol time (sec)
NT = 3; % Number of symbol periods between beginning and peak of impulse response

a = Ts*[.5, .75, 1, 2];
B = sqrt(log(2)/2)./(a);

t = linspace(-NT*Ts,NT*Ts,1000)';
hg = zeros(length(t),length(a));
for k = 1:length(a),
    hg(:,k) = sqrt(pi)/a(k)*exp(-(pi*t/a(k)).^2);
end

plot(t/Ts,hg)
title('Impulse response of a continuous-time Gaussian filter for various bandwidths');
xlabel('Normalized time (t/Ts)')
ylabel('Amplitude')
legend(sprintf('a = %g*Ts',a(1)/Ts),sprintf('a = %g*Ts',a(2)/Ts),sprintf('a = %g*Ts',a(3)/Ts),sprintf('a = %g*Ts',a(4)/Ts))