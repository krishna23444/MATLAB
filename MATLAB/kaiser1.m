clc
clear all
N=input('enter the value of points for  the  kaiser window')
b=input ('enter the value of b') 
n=(N-1)/2;
I=1;
for j= 1:22
    I=I+(((b/2)^j/(factorial(j))))^2;
 
end
I; 
for i =-n:n
    
    c = b* sqrt(1-(2*i/(N-1))^2);
    
    Ic=1;
    for j= 1:22
         Ic=Ic+(((c/2)^j/(factorial(j))))^2;
    end
    Ic;
    
    k(i+n+1)=Ic/I;
end 
 
    k1 =fft (k,512); 
    k2 = 20*log10 (abs(k1/max(k1)));
    subplot(211)
    plot(k)
    xlabel('magnitude response of kaiser window')
    subplot(212)
    plot(k2)
    xlabel('frequency response of kaiser window')
