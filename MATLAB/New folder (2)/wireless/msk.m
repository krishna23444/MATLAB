clc
clear all
fc=input('enter carrier frequency');
D=input('1. enter matrix manually  2.take random matrix');
if D==1
    Y=input('enter the matrix');
    N=length(Y);
elseif D==2
    N=input('enter no. of bits');
    Y=2*(randint(1,N,2))-1;
end
for i=1:N/2
    q(i)=Y(2*(i-1)+1);
    I(i)=Y(2*i);
end
t=0:.001:N/2;
o=0:.001:((N/2)+.5);
w=sin(pi*t);
x=[zeros(1,500) sin(pi*t)];
% c=cos(2*fc*pi*o);
% C=sin(2*fc*pi*o);
for i=1:N/2
    if q(i)==-1 && mod(i,2)==1 || q(i)==1 && mod(i,2)==0
        w((i-1)*1000+1:i*1000+1)=-w((i-1)*1000+1:i*1000+1);
    end
    if I(i)==-1 && mod(i,2)==1 || I(i)==1 && mod(i,2)==0
        x(((i-1)*1000)+500:(i*1000)+500)=-x(((i-1)*1000)+500:(i*1000)+500);
    end
end
w=[w zeros(1,500)];
% R=c.*w;
% P=C.*x;
 B=w+x;
subplot(2,2,1);plot(x);title('Q channel signal')
subplot(2,2,2);plot(w);title('I channel signal')

% subplot(2,2,3);plot(B);title('MSK continuous phase signal')
% D=fft(B);
% U=20*log10(abs(D/max(D)));
% g=1000/6501*(0:1500);
% subplot(2,2,4);plot(g,U(1:1501));title('power spectral density');text(fc+3,-5,'fc')
% t=0:.001:((N/2)+.5);

% D=B.*sin(2*fc*pi*t);
% U=B.*cos(2*fc*pi*t);
% D=D.*sin(pi*t);
% U=U.*cos(pi*t);
% figure(2)
% subplot(2,1,2);plot(D);
% subplot(2,1,1);plot(U);
% % l=1
% % for b=1:(N/2)+3
% %     if mod(b,2)==1
% %         l(b+1)=l(b)+500
% %     else
% %         l(b+1)=l(b)+1000
% %     end
% % end
% 
% Q=0
% for a=1:(N/2)-2
%   s1(a)=sum(U(Q*1000+1):U(1000*(Q+1)));
%   s2(a)=sum(D(Q*1000+1):D(1000*(Q+1)));
%   Q=Q+1
% end 
% 
