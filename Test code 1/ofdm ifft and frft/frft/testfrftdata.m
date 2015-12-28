clear all 
close all
clc

disp('channel types are :- ');
disp('1.AWGN    2. RAYLEIGH     3. NAKAGAMI    4. RICIAN   ');
ch1=input('enter your choice = ');

ipifrft=[1 2 3 4 5 6]

a=1;
opifrft=frfttxlkfn(ipifrft,a);
opifrft;
data_tx = opifrft;

% SNR1=0:5:100;
%  for p=1:length(SNR1)
%     snr=SNR1(p);
snr = 60
data_rx=channellkfn(data_tx',snr,ch1);

opfrft=frftrxlkfn(data_rx,-a);
opfrft;
if (mod(length(opfrft),2)==0)
    asd = rot90(opfrft);
fgh = rot90(asd);
for i= 1:length(ipifrft)-1
    zxc(i) = fgh(i);
end
for j= 2:length(ipifrft)
    opfrft(j) = zxc(j-1);
end
else
       opfrft1= opfrft';
 opfrft = rot90(opfrft1);
end
opfrft'
    

%  a=(opfrft~=ipifrft)
% opfrft