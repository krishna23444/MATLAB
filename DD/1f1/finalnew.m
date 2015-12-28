clc
clear all
close all
format long G
del=.02;
syms phi 
u=1;
mu=1;

% 1-abs(t)/13
% syms t u phi
% WW=int((1-2*abs(t))*exp((t^2)*cot(phi)-2*u*t*csc(phi)),t,-1,1)
% WW*((-csc(phi)*exp(1i*2*phi))^(1/4)*exp(1i*pi*(u^2)*cot(phi)))





% X=-exp(pi*u^2*cot(phi)*1i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/(2*cos(phi)) - (erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/cos(phi) + sin(phi)/(2*exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(2251799813685248*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)));


%  dif= - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/(2*cos(phi)) - (erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/cos(phi) + sin(phi)/(2*exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(2251799813685248*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)))*i + (exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*(sin(2*phi)*exp((2*u + cos(phi))/sin(phi))*(-cos(phi)/sin(phi))^(1/2)*(8987408751908856456289443643392 - (1100640136065409*i)/2) - 35949635007635421321558147203072*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (sin(2*phi)*(-cos(phi)/sin(phi))^(1/2)*((1100640136065409*i)/2 - 8987408751908856456289443643392))/exp((2*u - cos(phi))/sin(phi)) - 5070602400912917605986812821504*pi^(1/2)*sin(2*phi)*exp((2*u + cos(phi))/sin(phi))*(-cos(phi)/sin(phi))^(1/2) - (35949635007635421321558147203072*pi^(1/2)*u^2*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (4493704375954427665194768400384*pi^(1/2)*sin(2*phi)*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*pi^(1/2)*u^2*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (5070602400912917605986812821504*pi^(1/2)*sin(2*phi)*(-cos(phi)/sin(phi))^(1/2))/exp((2*u - cos(phi))/sin(phi)) + 17974817503817710660779073601536*u*exp((2*u + cos(phi))/sin(phi))*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (8987408751908855330389536800768*pi^(1/2)*sin(2*phi)*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*pi^(1/2)*u^2*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (4493704375954427665194768400384*pi^(1/2)*sin(2*phi)*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2))/exp((2*u - cos(phi))/sin(phi)) + (pi^(1/2)*u*erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*(- 17974817503817712912578887286784*i - 1100640136065409))/exp(u^2/(cos(phi)*sin(phi))) + (pi^(1/2)*u*erf((u*i + cos(phi)*i)...
%      /(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*...
%      (17974817503817712912578887286784*i + 1100640136065409))/exp(u^2/(cos(phi)*sin(phi)))))...
%      /(10141204801825835211973625643008*pi^(1/2)*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2));

X=-exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/cos(phi) - (2*sin(phi))/cos(phi) + sin(phi)/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (2*pi^(1/2)*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)));
dif=exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*(2/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (4*u)/cos(phi)^2 - (2*exp((2*u + cos(phi))/sin(phi)))/cos(phi) + (2*u*exp((u + cos(phi))^2/(cos(phi)*sin(phi))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) + (2*u*exp((u - cos(phi))^2/(cos(phi)*sin(phi))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) - (pi^(1/2)*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*u^2*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) - (4*pi^(1/2)*u^2*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*u^2*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*u*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*sin(phi)*(cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*((2*i)/(pi^(1/2)*exp((u*i - cos(phi)*i)^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)) - (2*i)/(pi^(1/2)*exp((u*i + cos(phi)*i)^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2))) - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/cos(phi) - (2*sin(phi))/cos(phi) + sin(phi)/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (2*pi^(1/2)*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)))*i;

 y = sqrt((1-1i*cot(phi))/2*pi);
q = pi*(1i^mu)*(1+1i)^(1-mu)/(cot(phi)^((1-mu)/2));
p = 1i*(1+1i)*sqrt(2*csc(2*phi))/gamma(mu/2);


   
  
   Dd = y*q*(1/gamma((1+mu))/2)*hypergeom((1-mu)/2,1/2,-1i*(u^2)*csc(2*phi))*(X*1i*u*sin(phi)+cos(phi)*dif)...
       +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*dif)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))...
       +y*p*q*cos(phi)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X...
       +y*q*hypergeom((3-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
       +y*p*q*cos(phi)*hypergeom((4-mu)/2,5/2,-1i*(u^2)*csc(2*phi))*u*X*((2-mu)/3);





s1=1;
X1=50000*ones(1,10);
Y1=50000*ones(1,10);
for phi=.1*pi:.1:.4*pi
   
    q1=1;
    N=1;
    Vd(s1)=double(subs(Dd));
    while  abs(X1(q1,s1))>(del/100)*abs(real(Vd(s1))) && abs(Y1(q1,s1))>(del/100)*abs(imag(Vd(s1)))
    q1=q1+1;
  
    D = y*q*(1/gamma((1+mu))/2)*FF11((1-mu)/2,1/2,N,u,phi)*(X*1i*u*sin(phi)+cos(phi)*dif)...
      + y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*dif)*FF11((2-mu)/2,3/2,N,u,phi)...
      + y*p*q*cos(phi)*FF11((2-mu)/2,3/2,N,u,phi)*X...
      + y*q*FF11((3-mu)/2,3/2,N,u,phi)*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
      + y*p*q*cos(phi)*FF11((4-mu)/2,5/2,N,u,phi)*u*X*((2-mu)/3);
  
    V(q1,s1)=double(subs(D))
    
    X1(q1,s1)=real(Vd(s1)-V(q1,s1));
    Y1(q1,s1)=imag(Vd(s1)-V(q1,s1));
    N=N+1
    end
s1=s1+1
end
Z=complex(X1,Y1);
surf(20*log10(abs(Z)))
   
    


    