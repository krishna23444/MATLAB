clc
clear all
close all
for a=.4
    b=fir1(122,.6,'high');
    
    Fa=dFRT(123,a);
    ff=b*Fa;
    y=20*log10(abs(ff)/max(abs(ff)));
    plot(fftshift(y))
    grid on
    hold on
end





