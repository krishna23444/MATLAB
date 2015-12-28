clear all
clc

K=menu('choose a window','rectangular','hann','hamming','barlett','blackman','kaiser');



N=input('enter the no of points for window');
F=input('enter the sampling frequency');

if K==6
    b=input('enter the value B');
end

N1=ceil(N/2);


if N/2==N1
      N=N+1;    
      n=((N-1)/2)

      


for i= -n:n
    
    if K==1
    r(i+n+1)=1;
    else if K==2
    r(i+n+1)=.5+.5*cos(2*pi*i/(N-1));
        else if K==3
    r(i+n+1)=.54+.46*cos(2*pi*i/(N-1));
    else if K==4
    r(i+n+1)=1-2*sqrt(i^2)/(N-1);
        else if K==5
    r(i+n+1)=.42+.5*cos(2*pi*i/(N-1))+.08*cos(4*pi*i/(N-1));
            else  if K==6
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                end
                    
            end
        end
            end
        end
    end
    
end

r1=fft(r,F);
r2=20*log10(abs(r1/max(r1)));
plot(r2)
hold on
grid on;

else
n=((N-1)/2)

for i= -n:n
    
    if K==1
    r(i+n+1)=1;
    else if K==2
    r(i+n+1)=.5+.5*cos(2*pi*i/(N-1));
        else if K==3
    r(i+n+1)=.54+.46*cos(2*pi*i/(N-1));
    else if K==4
    r(i+n+1)=1-2*sqrt(i^2)/(N-1);
        else if K==5
    r(i+n+1)=.42+.5*cos(2*pi*i/(N-1))+.08*cos(4*pi*i/(N-1));
    else  if K==6
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                end
    
            end
        end
            end
        end
    end
    
end

r1=fft(r,F);
r2=20*log10(abs(r1/max(r1)));
plot(r2)
hold on
grid on
end   