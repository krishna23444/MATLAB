function y=fi(I,hf1,m,N)
S2=2^14;
p=(N-3)/(N-1);

AA=ceil(m*S2)-ceil(m*p*S2)+1;
zz=linspace(p*m*pi,m*pi,AA);

d=(pi/S2)*zz(I);
[y,u]=freqz(hf1,1,zz(I));
y=abs(y)-d;
    
    

