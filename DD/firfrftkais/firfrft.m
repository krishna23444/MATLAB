clc
clear all


N=27;
g=3.9754;
wn=.5;
a=.05;

wind=[kaiser(N,g); zeros(500,1)];

% wind=[zeros(1,10) kaiser(N,g)' zeros(1,10)];


%    wind1=Disfrft(wind,a);
    
%     coeff=fir1(N-1,wn,abs(wind1));
%     freqz(coeff,1)

z=abs(Disfrft(wind,a));
y=20*log10(z/max(z));
plot(y)
grid on

    
    
    
