%effect of differentiation on time frequency repr
clc
close all
clear all
chex;
load Q;
ab=o;

for k=1:4
    ab=conv(ab,Q);
    figure(1)
    qwigner2(ab);
    title(['Differentiation Order: ', num2str(k)]);
    pause(1)
    figure(2)
    contour(abs(stft2(ab, 1, 256,1,9, 'short')));
    title(['Differentiation Order: ', num2str(k)]);
    pause(1)
end

    
    
    

