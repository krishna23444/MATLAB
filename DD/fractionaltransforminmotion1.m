clc
clear all
close all

syms u phi
X=-exp(pi*u^2*cot(phi)*1i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/(2*cos(phi)) - (erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/cos(phi) + sin(phi)/(2*exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(2251799813685248*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)));


s=2;
X1(:,1)=zeros(1,21)'
for phi=.1*pi:.2:.99*(pi/2)
q=1;    

    for u=-1:.1:1
        
        X1(q,s)=double(subs(X));
        q=q+1;
    end
    s=s+1;
    
    surf(fftshift(abs(X1),1));
    colormap(spring)
    
end
    


