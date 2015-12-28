clc
clear all
v=1;
for i=1:10
    z(v)=1
    v=v+1;
end

    
Z=fft(z,127);
r=20*log10(abs(Z/max(Z)))
plot(r)