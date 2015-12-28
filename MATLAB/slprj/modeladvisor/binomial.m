function [dat1,dat2,dat3]=binomial(choice,p,N,Z0,Rl);

% QUARTER WAVELENGTH TRANSFORMER WITH THE USE OF BINOMIAL METHOD
%
% INPUT PARAMETERS ARE EITHER THE MAXIMUM FRACTIONAL BANDWIDTH OR THE 
%
% MAXIMUM TOLERABLE REFLECTION COEFFICIENT, THE NUMBER OF USED
%
% SUBSECTIONS (N), THE CHARACTERISRIC INPUT IMPEDANCE (Z0) AND
%
% THE LOAD INPUT RESISTANCE (Rl)

Gamma_comp=tschebcomp(choice,p,N,Z0,Rl);

mult1=(Rl-Z0)/(Rl+Z0);

n=0 : N;

C_n=(fact(N))./(fact(N-n).*fact(n));

ro_n=2.^(-N)*((Rl-Z0)/(Rl+Z0)).*C_n; %estimation of the reflections coefficients

Z=zeros(1,N+2);

Z(1)=Z0;

Z(N+2)=Rl;

for i=2 : N+2,
   
   Z(i)=((1+ro_n(i-1))./(1-ro_n(i-1)))*Z(i-1); %estimation of the characteristic impedance of each subsection
   
end;

dat1=ro_n; 

dat2=Z;

switch choice
case 1
   dat3(1)=p;
   dat3(2)=abs(((cos((pi/4)*(2-p)))^N)*(mult1));
otherwise
   dat3(2)=p;
   dat3(1)=abs(2-(4/pi)*acos((p/abs(mult1))^(1/N)));
end

dat3(3)=(1+ dat3(2))/(1- dat3(2)); %estimation of the input VSWR

f=0 : 0.001 : 2;

theta=(pi/2)*(f);

exptheta=repmat(theta,[length(n) 1]);

expn=repmat(n',[1 length(f)]);

coeff=(exp(-j.*2*expn.*exptheta));

expro_n=repmat((ro_n)',[1 length(f)]);

Gamma=abs(sum(expro_n.*coeff,1)); %estimation of the Input reflection coeffecient in all the arange of fractional bandwidth

vert_plot=0 : 0.01 : abs(mult1);

max_plot(1:length(f))=dat3(2); clear j;

Gamma_single=abs(.5*mult1*(1+exp(-j*2*theta)));

figure; [h1]=plot(f,Gamma,'b',f,Gamma_single,f,max_plot,'r'); %properties of the figure
set(h1(2),'color',([81 164 109]/255));
set(h1(3),'linestyle','--');
set(gca,'units','normalized');
set(gca,'fontsize',14);
set(h1,'linewidth',2);
hl=legend(['Input reflection coefficient - ',num2str(N),' subsections'],'Single section','Maximun tolerable reflection coefficient');
set(hl,'position',[0.325 0.82 0.8 0.1]);
axis([-inf inf 0 inf]);
title(['Binomial Quarter-Wavelength Impedance Transformer with N = ',num2str(N)]);
xlabel('Relative frequency (f / f_0)');
ylabel('Input Reflection Coefficient  \Gamma_{in}');
grid;

figure; [h2]=plot(f,Gamma,'b',f,Gamma_comp,f,Gamma_single,f,max_plot,'r'); %properties of the figure
set(h2(2),'color',[1 .688 0]);
set(h2(3),'color',([81 164 109]/255));
set(h2(4),'linestyle','--');
set(gca,'units','normalized');
set(gca,'fontsize',14);
set(h2,'linewidth',2);
h2=legend(['Binomial method (N = ',num2str(N),')'],['Tschebyscheff method (N = ',num2str(N),')'],'Single section','Maximun tolerable reflection coefficient');
set(h2,'position',[0.277 0.82 0.8 0.1]);
axis([-inf inf 0 inf]);
title(['Binomial and Tschebyscheff Quarter-Wavelength Impedance Transformer with N = ',num2str(N)]);
xlabel('Relative frequency (f / f_0)');
ylabel('Input Reflection Coefficient  \Gamma_{in}');
grid;
