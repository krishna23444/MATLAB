clc
clear all
close all

v=1;
M=5;
W=[zeros(1,168) ones(1,864) zeros(1,168)];
L=-600:599;
q=1:1200;
R=sum(W(q));

for i=1:M+1
    s2=0;
    for l=1:M+1
        s1=0;
        
        for q=1:1200
        s1=s1+W(q)*cos(L(q)*pi*(i-1)/600)*cos(pi*L(q)*(l-1)/600)+1;
        s2=s2+W(q)*cos(L(q)*pi*(i-1)/600)*((L(q)*pi/600)^v);
        end
        Ta(i,l)=(pi/R*600)*s1;
        end
    Ia(i)=(pi/R*600)*cos(v*pi/2)*s2;
end


for i=1:M
    s2=0;
    for l=1:M
        s1=0;
        for q=1:1200
        s1=s1+W(q)*sin(L(q)*pi*i/600)*sin(pi*L(q)*l/600);
        s2=s2+W(q)*sin(L(q)*pi*i/600)*((L(q)*pi/600)^v)*sign((L(q)*pi/600));
        end
        Tb(i,l)=(pi/R*600)*s1;
        
    end
    Ib(i)=(pi/R*600)*sin(v*pi/2)*s2;
end

a=Ia*inv(Ta);
b=Ib*inv(Tb);

a1=abs(a);
b1=abs(b);

a2=(a1(2:6)+b1)/2;
b2=(a1(2:6)-b1)/2;

c=[fliplr(a2) a1(1) b2];
[x NN]=freqz(c,1,256:512,512);
a3=[linspace(0,pi,257)].^v;
x1=a3(50)/abs(x(50));
figure(2)
plot((1:257)*(pi/257),a3,'r');
hold on
grid on
plot((1:257)*(pi/257),abs(x)*x1)