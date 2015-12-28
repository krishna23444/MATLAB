clc
clear all
close all
format long G

syms phi u 


% 1-abs(t)/13
% WW=sqrt(1-1i*cot(phi))*int((1-abs(t)/13)*exp(1i*pi*(u^2*cot(phi)-2*u*t*csc(phi)+t^2*cot(phi))),t,-13,13)
 
% syms t u phi
% WW=int((1-abs(t)/13)*exp((t^2)*cot(phi)-2*u*t*csc(phi)),t,-1,1)
% WW*((-csc(phi)*exp(1i*2*phi))^(1/4)*exp(1i*pi*(u^2)*cot(phi)))
%X=-exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((26*u + 169*cos(phi))/sin(phi))*sin(phi))/(26*cos(phi)) - (erf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/(13*cos(phi)) + sin(phi)/(26*exp((26*u - 169*cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(29273397577908224*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(58546795155816448*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(58546795155816448*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)))
% dif=(exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((2*pi^(1/2)*sin(2*phi)*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (8*pi^(1/2)*u^2*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (pi^(1/2)*sin(2*phi)*erf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (pi^(1/2)*sin(2*phi)*erf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - 8*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (4*pi^(1/2)*u^2*erf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (4*pi^(1/2)*u^2*erf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + 4*u*exp((26*u + 169*cos(phi))/sin(phi))*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (4*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2))/exp((26*u - 169*cos(phi))/sin(phi)) - (52*pi^(1/2)*u*erf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*i)/exp(u^2/(cos(phi)*sin(phi))) + (52*pi^(1/2)*u*erf((u*i + 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*i)/exp(u^2/(cos(phi)*sin(phi)))))/(52*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((26*u + 169*cos(phi))/sin(phi))*sin(phi))/(26*cos(phi)) - sin(phi)/(13*cos(phi)) + sin(phi)/(26*exp((26*u - 169*cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*erf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*u*erf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(13*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*(erf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + 13*i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)))*i


phi=pi/4;
mu=0.5;

% X=-exp(pi*u^2*cot(phi)*1i)*(-exp(2*phi*1i)/sin(phi))^(1/4)*((exp((26*u + 169*cos(phi))/sin(phi))*sin(phi))/(26*cos(phi)) - sin(phi)/(13*cos(phi)) - (((-pi)^(1/2)*errf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - ((-pi)^(1/2)*errf((u*i + 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))))/(2*(cos(phi)/sin(phi))^(1/2)) + sin(phi)/(26*exp((26*u - 169*cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*cos(phi)*errf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) + (pi^(1/2)*u*cos(phi)*errf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) - (pi^(1/2)*u*errf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2)))*cos(phi))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)));
% dif=exp(pi*u^2*cot(phi)*1i)*(-exp(2*phi*1i)/sin(phi))^(1/4)*(1/(exp((26*u - 169*cos(phi))/sin(phi))*cos(phi)) - exp((26*u + 169*cos(phi))/sin(phi))/cos(phi) - (2*u)/(13*cos(phi)^2) + ((2*(-pi)^(1/2)*i)/(pi^(1/2)*exp((u*i - 13*cos(phi)*i)^2/(cos(phi)*sin(phi)))*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)) - (2*(-pi)^(1/2)*i)/(pi^(1/2)*exp((u*i + 13*cos(phi)*i)^2/(cos(phi)*sin(phi)))*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)) - (2*(-pi)^(1/2)*u*errf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*sin(phi)) + (2*(-pi)^(1/2)*u*errf((u*i + 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*sin(phi)))/(2*(cos(phi)/sin(phi))^(1/2)) + (u*exp((u - 13*cos(phi))^2/(cos(phi)*sin(phi))))/(13*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) + (u*exp((u + 13*cos(phi))^2/(cos(phi)*sin(phi))))/(13*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) + (pi^(1/2)*errf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2)))*cos(phi))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) - (2*pi^(1/2)*u^2*errf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^3*(-cos(phi)/sin(phi))^(5/2)) - (pi^(1/2)*cos(phi)*errf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) - (pi^(1/2)*cos(phi)*errf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) + (pi^(1/2)*u^2*errf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^3*(-cos(phi)/sin(phi))^(5/2)) + (pi^(1/2)*u^2*errf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^3*(-cos(phi)/sin(phi))^(5/2))) - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((26*u + 169*cos(phi))/sin(phi))*sin(phi))/(26*cos(phi)) - sin(phi)/(13*cos(phi)) - (((-pi)^(1/2)*errf((u*i - 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - ((-pi)^(1/2)*errf((u*i + 13*cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))))/(2*(cos(phi)/sin(phi))^(1/2)) + sin(phi)/(26*exp((26*u - 169*cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*cos(phi)*errf((u - 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) + (pi^(1/2)*u*cos(phi)*errf((u + 13*cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(26*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)) - (pi^(1/2)*u*errf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2)))*cos(phi))/(13*exp(u^2/(cos(phi)*sin(phi)))*sin(phi)^2*(-cos(phi)/sin(phi))^(5/2)))*1i;


X=exp(pi*u^2*i)*(exp(169 - 26*2^(1/2)*u)/26 + exp(26*2^(1/2)*u + 169)/26 - ((-pi)^(1/2)*(errf(2^(1/2)*u*i - 13*i) - errf(13*i + 2^(1/2)*i*u)))/(2*exp(2*u^2)) - (u*errf(2^(1/2)*u*i)*((-2)*pi)^(1/2))/(13*exp(2*u^2)) + (u*errf(2^(1/2)*u*i - 13*i)*((-2)*pi)^(1/2))/(26*exp(2*u^2)) + (u*errf(2^(1/2)*u*i + 13*i)*((-2)*pi)^(1/2))/(26*exp(2*u^2)) - 1/13)*((7517755133891439*i)/18014398509481984 - 567170825088771/562949953421312);
dif=exp(pi*u^2*i)*(((2^(1/2)*(7982422502469483/2251799813685248 - (1100640136065409*i)/5070602400912917605986812821504))/(pi^(1/2)*exp((2^(1/2)*u*i - 13*i)^2)) + (2^(1/2)*((1100640136065409*i)/5070602400912917605986812821504 - 7982422502469483/2251799813685248))/(pi^(1/2)*exp((2^(1/2)*u*i + 13*i)^2)))/(2*exp(2*u^2)) + (er
      
y = sqrt((1-1i*cot(phi))/2*pi);
q = pi*(1i^mu)*(1+1i)^(1-mu)/(cot(phi)^((1-mu)/2));
p = 1i*(1+1i)*sqrt(2*csc(2*phi))/gamma(mu/2);

D = y*q*(1/gamma((1+mu))/2)*hypergeom((1-mu)/2,1/2,-1i*(u^2)*csc(2*phi))*(X*1i*u*sin(phi)+cos(phi)*dif)...
       +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*dif)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))...
       +y*p*q*cos(phi)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X...
       +y*q*hypergeom((3-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
       +y*p*q*cos(phi)*hypergeom((4-mu)/2,5/2,-1i*(u^2)*csc(2*phi))*u*X*((2-mu)/3);



for u=-13:13
    Y(u+14)=double(subs(D))
end






   
    


    