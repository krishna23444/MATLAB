%Gaussiun Random Number.
clc
clear

figure;
sd = 5;
x = -10: 0.3 : 10;
y =  (1 /sqrt(2*pi*sd^2)) .* exp(-x.^2 ./ (2*sd) );

stem(x,y);
title('Gaussian Random Number','FONTSIZE',20);
xlabel('x - axis','FONTSIZE',18);
ylabel('y - axis','FONTSIZE',18);
axis([-12 12 0 0.1]);