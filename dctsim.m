clc
clear all
close all
N=8;

C = zeros(N,N);
for m = 0:1:N-1
    for n = 0:1:N-1
        if n == 0
            k = sqrt(1/N);
        else
            k = sqrt(2/N);
        end
        C(m+1,n+1) = k*cos( ((2*m+1)*n*pi) / (2*N));
    end
end

figure(1);
colormap('gray');

for m = 0:1:N-1
    for n = 0:1:N-1
        subplot(N,N,m*N+n+1);
        Y = [zeros(m,N);
        zeros(1,n) 1 zeros(1,N-n-1);
        zeros(N-m-1,N)];
        X = C'*Y*C;
        imagesc(X);
        axis square;
        axis off;
    end
end


     xx=imread('D:\MATLAB 2010 Portable\bin\MATLAB\bw5.jpg');
figure(2)
imagesc(xx)
colormap('gray');
x=xx(40:47,50:57);
figure(3)
imagesc(x)
colormap('gray');
x=double(x);
  cc = C'*x*C 