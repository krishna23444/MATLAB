clc
clear all
close all

syms phi u
mu=.5;

y = sqrt((1-1i*cot(phi))/2*pi);
q = pi*(1i^mu)*(1+1i)^(1-mu)/(cot(phi)^((1-mu)/2));
p = 1i*(1+1i)*sqrt(2*csc(2*phi))/gamma(mu/2);


% X=-exp(pi*u^2*cot(phi)*1i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/(2*cos(phi)) - (erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/cos(phi) + sin(phi)/(2*exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(2251799813685248*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)));
% 
%  dif= - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/(2*cos(phi)) - (erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(17974817503817712912578887286784*i + 1100640136065409) + erf((u*i + cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*(- 17974817503817712912578887286784*i - 1100640136065409))/(20282409603651670423947251286016*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)) - sin(phi)/cos(phi) + sin(phi)/(2*exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (3991211251234741*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(2251799813685248*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (3991211251234741*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(4503599627370496*exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)))*i + (exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*(sin(2*phi)*exp((2*u + cos(phi))/sin(phi))*(-cos(phi)/sin(phi))^(1/2)*(8987408751908856456289443643392 - (1100640136065409*i)/2) - 35949635007635421321558147203072*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (sin(2*phi)*(-cos(phi)/sin(phi))^(1/2)*((1100640136065409*i)/2 - 8987408751908856456289443643392))/exp((2*u - cos(phi))/sin(phi)) - 5070602400912917605986812821504*pi^(1/2)*sin(2*phi)*exp((2*u + cos(phi))/sin(phi))*(-cos(phi)/sin(phi))^(1/2) - (35949635007635421321558147203072*pi^(1/2)*u^2*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (4493704375954427665194768400384*pi^(1/2)*sin(2*phi)*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*pi^(1/2)*u^2*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (5070602400912917605986812821504*pi^(1/2)*sin(2*phi)*(-cos(phi)/sin(phi))^(1/2))/exp((2*u - cos(phi))/sin(phi)) + 17974817503817710660779073601536*u*exp((2*u + cos(phi))/sin(phi))*sin(phi)*(-cos(phi)/sin(phi))^(1/2) + (8987408751908855330389536800768*pi^(1/2)*sin(2*phi)*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*pi^(1/2)*u^2*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) - (4493704375954427665194768400384*pi^(1/2)*sin(2*phi)*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/exp(u^2/(cos(phi)*sin(phi))) + (17974817503817710660779073601536*u*sin(phi)*(-cos(phi)/sin(phi))^(1/2))/exp((2*u - cos(phi))/sin(phi)) + (pi^(1/2)*u*erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*(- 17974817503817712912578887286784*i - 1100640136065409))/exp(u^2/(cos(phi)*sin(phi))) + (pi^(1/2)*u*erf((u*i + cos(phi)*i)...
%      /(sin(phi)*(cos(phi)/sin(phi))^(1/2)))*sin(phi)*(-cos(phi)/sin(phi))^(1/2)*(cos(phi)/sin(phi))^(1/2)*...
%      (17974817503817712912578887286784*i + 1100640136065409))/exp(u^2/(cos(phi)*sin(phi)))))...
%      /(10141204801825835211973625643008*pi^(1/2)*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2));
X=-exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/cos(phi) - (2*sin(phi))/cos(phi) + sin(phi)/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (2*pi^(1/2)*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)));

dif=exp(pi*u^2*cot(phi)*i)*(-exp(2*phi*i)/sin(phi))^(1/4)*(2/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) - (4*u)/cos(phi)^2 - (2*exp((2*u + cos(phi))/sin(phi)))/cos(phi) + (2*u*exp((u + cos(phi))^2/(cos(phi)*sin(phi))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) + (2*u*exp((u - cos(phi))^2/(cos(phi)*sin(phi))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2) - (pi^(1/2)*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*u^2*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) - (4*pi^(1/2)*u^2*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) + (2*pi^(1/2)*u^2*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)^2*sin(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*u*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*sin(phi)*(cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*((2*i)/(pi^(1/2)*exp((u*i - cos(phi)*i)^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)) - (2*i)/(pi^(1/2)*exp((u*i + cos(phi)*i)^2/(cos(phi)*sin(phi)))*sin(phi)*(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2))) - 2*pi*u*exp(pi*u^2*cot(phi)*i)*cot(phi)*(-exp(2*phi*i)/sin(phi))^(1/4)*((exp((2*u + cos(phi))/sin(phi))*sin(phi))/cos(phi) - (2*sin(phi))/cos(phi) + sin(phi)/(exp((2*u - cos(phi))/sin(phi))*cos(phi)) + (pi^(1/2)*u*erf((u + cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) + (pi^(1/2)*u*erf((u - cos(phi))/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (2*pi^(1/2)*u*erf(u/(sin(phi)*(-cos(phi)/sin(phi))^(1/2))))/(exp(u^2/(cos(phi)*sin(phi)))*cos(phi)*(-cos(phi)/sin(phi))^(1/2)) - (pi^(1/2)*(erf((u*i - cos(phi)*i)/(sin(phi)*(cos(phi)/sin(phi))^(1/2))) - erf(1/sin(phi)*(i*u + i*cos(phi))/(cos(phi)/sin(phi))^(1/2)))*i)/(2*exp(u^2/(cos(phi)*sin(phi)))*(cos(phi)/sin(phi))^(1/2)))*i;


Dd = y*q*(1/gamma((1+mu))/2)*hypergeom((1-mu)/2,1/2,-1i*(u^2)*csc(2*phi))*(X*1i*u*sin(phi)+cos(phi)*dif)...
       +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*dif)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))...
       +y*p*q*cos(phi)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X...
       +y*q*hypergeom((3-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
       +y*p*q*cos(phi)*hypergeom((4-mu)/2,5/2,-1i*(u^2)*csc(2*phi))*u*X*((2-mu)/3);

s=1;
  for phi=.1*pi:.1:.4*pi
      
       q=1;  
      for u=    -5:.5:5
          
           Vd(q,s)=double(subs(Dd));
           
           q=q+1;
      end
        s=s+1
   end
  
  surf(20*log10(abs(Vd)));zlabel('value)');ylabel('u');xlabel('phi');
          
          
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   