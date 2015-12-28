clc
clear all
M=input('enter M-ary = ');
N=10000;
r=randint(1,N,M);
r=r+1;
        
        
for m=1:M
   P(m)=cos(2*pi*(m-1)/M)+j*sin(2*pi*(m-1)/M);
end

for i=1:N
    t(i)=P(r(i));
end

r=r-1;
D=dec2bin(r);
k=1;

for i=1:N
    for j=1:log2(M)
        g(k)=D(i,j);
        k=k+1;
    end
end


for snr=1:10
     a=awgn(t,snr);
     if snr==10
          figure(1)
           hold on;
           grid on
     for i=1:M
     plot(real(P(i)),imag(P(i)),'rs');
     title('constellation diagram');
     end
     
     for i=1:100
            figure(1)
         plot(real(a(i)),imag(a(i)),'gh');
     end
     hold off
     end
     for i=1:N
         b(i)=mindist(a(i),P);
     end
    b1=b-1;
     J=dec2bin(b1);
k=1;
for i=1:N
    for j=1:log2(M)
        g1(k)=J(i,j);
        k=k+1;
    end
end
ber=0;
     for k=1:N*log2(M)
         if g(k)~=g1(k)
             ber=ber+1;
         end
     end
   B(snr)=ber/10000;
end
figure(2)
semilogy(1:10,B);
xlabel('SNR')
ylabel('BER')
grid on;