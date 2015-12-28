clear all 
close all
clc

disp('channel types are :- ');
disp('1.AWGN    2. RAYLEIGH     3. NAKAGAMI    4. RICIAN   ');
ch1=input('enter your choice = ');

a=-1;
b = [.42-.52i .78-.34i .8+.23i .5-.35i   ]            % even or odd
c=Disfrft(b,a)

snr = 60
data_rx=channellkfn(c',snr,ch1)

d= Disfrft(data_rx',-a)

conj(d')
