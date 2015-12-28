clc
clear all
close all
format long G




phi=pi/4;
mu=0.5;
% X=cdpei(1-abs(-13:13)/13,.5)
s=1;
for u=-13:.1:13
    
% X=exp((-231.03.*1i - 43.9823 .*1i.* u) .*u).* ((-0.011143 - 0.0269017 .*1i).* exp((231.03 .*1i + 47.1239 .*1i .*u) .*u) - ...
%     (0.00557152 +0.0134508 .*1i).* exp((462.06 .*1i + 47.1239 .*1i.*u) .*u) - ...
%     (0.00557152 + 0.0134508 .*1i).* exp(47.1239 .*1i .*u^2)+ ...
%     exp(3.14159 .*1i .*u.* (73.5391 + 7.*u)) .*((((-0.549342-0.227545 .*1i) - (0.119521 + 0.0495073) .*1i) .*u).* errf((-16.2931 + 16.2931 .*1i) - (3.54491 - 3.54491 .*1i) .*u) - (0.239042 + 0.0990145 .*1i) .*u.* errf((3.54491 - 3.54491 .*1i) .*u))...
%     +exp((231.03 .*1i + 21.9911 .*1i .*u) .*u) .*((-0.549342 -0.227545 .*1i) + ...
%     (0.119521 + 0.0495073 .*1i) .*u).* errf((-16.2931 + 16.2931 .*1i) + (3.54491 - 3.54491 .*1i) .*u));

X=(0.00306067 + 0.00306067 *1i)* sqrt(( 1 - 1i) *cot(phi))*...
(-12.5664 *exp( 3.14159 *1i* u^2 *(-7 + cos(2*phi))* csc(2* phi))*u* errf(((2.50663 - 2.50663 *1i)* u* cos(phi))/sqrt(cos(phi)^3* sin(phi)))*...
    sec(phi)^3 *sqrt(2* sin(2* phi) + sin(4* phi)) +...
    exp(3.14159 *1i* u^2 *(-7 + cos(2* phi))* csc(2* phi))* errf((1.25331 - 1.25331 *1i)* csc(phi) *sec(phi) *(-13 + 2* u *sec(phi)) *sqrt(cos(phi)^3 *sin(phi)))*...
           sec(phi)^2* (-40.8407 + 6.28319 *u* sec(phi))* sqrt(2* sin(2* phi) + sin(4* phi)) + ...
   exp(3.14159 *1i* u^2 *(-7 + cos(2* phi)) *csc(2* phi))*errf((1.25331 - 1.25331 *1i)* csc(phi)* sec(phi) *(13 + 2* u *sec(phi))* sqrt(cos(phi)^3 *sin(phi))) *...
   sec(phi)^2* (40.8407 + 6.28319* u* sec(phi)) *sqrt(2*sin(2* phi) + sin(4* phi)) - (4 + 4 *1i)* exp(3.14159 *1i* u^2* cot(phi))* tan(phi) +...
   (2 + 2 *1i)* exp( 3.14159 *1i* (-52* u + (169 + u^2) *cos(phi))* csc(phi))*...
     tan(phi) + (2 + 2* 1i)* exp((530.929* 1i+ 3.14159*1i* u^2) *cot(phi) + 163.363* 1i *u* csc(phi)) *tan(phi));

dif= exp(6.28319 *1i* (-72.3715 + u) *(-1.16759 + u))* ...
   ( exp(-3.14159 *1i* (-145.92 + u)* (-1.15817 + u))* ((3.10755 - 1.28719 *1i) - (0.676113 - 0.280055 *1i)* u) + ...
     exp(-3.14159 *1i* (-145.92 + u)* (-1.15817 + u)) *((-3.10755 + 1.28719 *1i) - (0.507085 - 0.210041 *1i)* u) + ...
     exp(-3.14159 *1i *(-219.849 + u)* (-0.768711 +  u))* ((3.10755 - 1.28719 *1i) + (0.0845142 - 0.0350069 *1i)* u) +... 
     exp(-3.14159 *1i* (-71.1643 + u) *(-2.37479 + u)) *((-3.10755 + 1.28719 *1i) + (0.0845142 - 0.0350069 *1i) *u) + ...
     exp(-3.14159 *1i* (-220.617 + u) *(3.28058*10^-16 + u)) *((3.10755 - 1.28719 *1i) + (0.676113 - 0.280055 *1i) *u)...
         + exp((231.03 *1i - 3.14159 *1i *u)* u) *((-3.10755 + 1.28719 *1i) + (0.676113 - 0.280055 *1i)* u) + ...
   exp(-28.2743 *1i* (-15.0983 + u) *(-1.2437 + u))* (((-0.119521 - 0.0495073 *1i) + ((10.0079 - 24.1613 *1i) - (2.17744 - 5.25681 *1i) *u) *u)* errf((16.2931 -16.2931 *1i) - (3.54491 - 3.54491 *1i)* u) + ...
((-0.239042 - 0.0990145 *1i) + ((1.66533*10^-15 + 2.22045*10^-16 *1i) - (4.35489 - 10.5136 *1i) *u) *u)* errf((3.54491 - 3.54491 *1i) *u) ...
       + ((0.119521 + 0.0495073 *1i) + u*((10.0079 - 24.1613 *1i) + (2.17744 - 5.25681 *1i)* u))* errf((16.2931-16.2931 *1i) + (3.54491 - 3.54491 *1i)* u)))


y = sqrt((1-1i*cot(phi))/2*pi);
q = pi*(1i^mu)*(1+1i)^(1-mu)/(cot(phi)^((1-mu)/2));
p = 1i*(1+1i)*sqrt(2*csc(2*phi))/gamma(mu/2);

D = y*q*(1/gamma((1+mu))/2)*hypergeom((1-mu)/2,1/2,-1i*(u^2)*csc(2*phi))*(X*1i*u*sin(phi)+cos(phi)*dif)...
       +y*p*q*u*(X*1i*u*sin(phi)+cos(phi)*dif)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))...
       +y*p*q*cos(phi)*hypergeom((2-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X...
       +y*q*hypergeom((3-mu)/2,3/2,-1i*(u^2)*csc(2*phi))*X*((1-mu)*cos(phi)/gamma((1+mu)/2))...
       +y*p*q*cos(phi)*hypergeom((4-mu)/2,5/2,-1i*(u^2)*csc(2*phi))*u*X*((2-mu)/3);




    Y(s)=double(subs(D))
    s=s+1
end










   
    


    