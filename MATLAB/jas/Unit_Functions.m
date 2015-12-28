%% Unit Functions.

clc
clear

%% Unit Step
x = 0:10;
y = ones(1,11);
subplot(2,2,1);
stem(x,y);
title('Unit Step','FONTSIZE',20);
xlabel('x - axis','FONTSIZE',18);
ylabel('y - axis','FONTSIZE',18);
axis([0 10 0 2]);

%% Unit Impulse
x = 0:10;
y = zeros(1,11);
y(1) = 1;
subplot(2,2,2);
stem(x,y);
title('Unit Impulse','FONTSIZE',20);
xlabel('x - axis','FONTSIZE',18);
ylabel('y - axis','FONTSIZE',18);
axis([0 10 0 2]);

%% Unit Ramp
x = 0:10;
y = x;
subplot(2,2,3);
stem(x,y);
title('Unit Ramp','FONTSIZE',20);
xlabel('x - axis','FONTSIZE',18);
ylabel('y - axis','FONTSIZE',18);
axis([0 10 0 15]);