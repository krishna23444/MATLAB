function plotter(h)
%plotter	plot stuff about h
%subplot(2,1,1),stem(h)
fftlength = 1024;
pad = zeros(1,fftlength-length(h));
hpad = [h,pad];
faxis = (1:fftlength/2)/(fftlength/2);
hfreq = fft(hpad);
%subplot(2,1,2)
plot(faxis,10*log(abs((1/max(hfreq))*hfreq(1:length(hfreq)/2))));
axis([0 1 -80 10]);
%plot(faxis(1:(.15*fftlength)),abs((1/hfreq(1))*hfreq(1:(.15*fftlength))));
%axis([0 .15 .9 1.03])

ylabel('dB');
xlabel('normalized frequency');


