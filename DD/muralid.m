clc
clear all
close all
for a=.9
%     b=fir1(122,.6,'high');
    b=(1:123);
    figure(2)
    plot(b)
    Fa=dFRT(123,a);
    ff=b*Fa;
%     y=20*log10(abs(ff)/max(abs(ff)));
figure(1)
    plot(fftshift(abs(ff)))
    grid on
    hold on
end





