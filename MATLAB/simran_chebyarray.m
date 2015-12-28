function YI=simran_chebyarray(d,s,n)
% this function calculates excitation coefficients,Directivity,Beamwidth of
% a Tchebysheff array provided distance between elements(d in wavelengths),side lobe
% level(s dB),number of elements(n)
clc;
r=10^(s/20);
an=.5*(((r+sqrt(r^2-1))^(1/(n-1))) + ((r-sqrt(r^2-1))^(1/(n-1))));
syms a;
tp=chb(n-1);
A(ceil(n/2))=(an)^(n-1);
if mod(n,2)==0
    for i=1:n/2
        o(i)=chb(2*i-1);
        o(i)=subs(o(i),a/an);
        U(i,:)=[zeros(1,(n-length(sym2poly(o(i))))) sym2poly(o(i))];
    end
else
    for i=1:((n-1)/2)+1
        o(i)=chb(2*(i-1));
        o(i)=subs(o(i),a/an);
        U(i,:)=[zeros(1,(n-length(sym2poly(o(i))))) sym2poly(o(i)) ];
    end
end

tpp=sym2poly(tp);
tpp=tpp(1:2:n);
U=U(:,1:2:n);
U(ceil(n/2),:)=A(ceil(n/2))*U(ceil(n/2),:);

for i=2:ceil(n/2)
     
 A(ceil(n/2)-i+1)=(tpp(i)-sum(U(ceil(n/2)-i+2:ceil(n/2),i:i)))/U(ceil(n/2)-(i-1),i)    ;
 U(ceil(n/2)-i+1,:)=A(ceil(n/2)-i+1)*U(ceil(n/2)-i+1,:);
 end
A=A/min(A);
 syms the;
u=d*pi*cos(the);
AF=0;
if mod(n,2)==0

    for i=0:ceil(n/2)
    AF=[AF cos((2*i+1)*u)];
    end

else
    
    for j=1:ceil(n/2)
    AF=[AF cos(2*(j-1)*u)] ;
    end

    A(1)=2*A(1);
    A=A/min(A);
end
figure(1)
S=sum(AF);
ezpolar(S);view([90 -90]);

disp('Excitation Coefficients are '),disp(A);
theta = -pi : pi/111 : pi;
phi = 0 : pi/111 : (2*pi);
[phi1,theta1] = meshgrid(phi,theta);
u=d*pi*cos(theta1);
[X,Y,Z] = sph2cart(phi1,pi/2-theta1,subs(S,u));
figure(2)
mesh(X,Y,Z);if d~=1
    view([180 0 0]);camroll(90)
end
f=1+.636*(2*cosh(sqrt((acosh(r))^2-(pi)^2))/r)^2;
D0=10*log10(2*r^2/(1+(r^2-1)*f/((n-1)*d+d)));
disp('Directivity(dB) of the array is '),disp(D0);
disp('3-dB beamwidth(degrees) of the array is '),disp(101.5/D0);

function y=chb(x);
syms a;
y=simple(expand(cos(x*acos(a))));












