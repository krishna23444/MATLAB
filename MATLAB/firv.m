%Program to design an FIR fiter using fir2
F =[0 0.25 0.25 0.5 0.65 0.75 0.9 1.0];
M = [0 1 0.5 0.5 0 0 0.3 0.3];
b=fir2(128, F, M);
[h,w]=freqz(b, 1, 256);
H=abs(h);
plot(w/pi,H);Grid;

ylabel('Magnitude')
xlabel('Normalized frequency')
%end