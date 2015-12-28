clc
clear all

K=menu('choose filter type','LPF','HPF','BPF','BSF','Quit');
H=menu('choose window selection','Kaiser Only','All Windows','Rectangular','Hann','Hamming','Blackman','Kaiser');
if K~=5

f1=input('enter edge freq(Hz)=');
a=input('enter sb attenuation(dB)=');
fs=input('enter sampling freq(Hz)=');
tw=input('enter transtion width(Hz)=');
if H==1||H==7
dp=input('enter passband deviation=');
ds=input('enter stopband deviation=');
d=min(dp,ds)

if -20*log10(d)>a & dp~=0 & ds~=0
    a=-20*log10(d);
end
end

if K>2
    f22=input('enter second edge freq(Hz)=');
    f2=(f22+(tw/2))/fs;
    w2=2*pi*f2;
 if f22>=fs/2&&K==3
    disp('filter is high pass');
    K==2;
    elseif f1==0&&K==4
    disp('filter is low pass');
    K==1;
    end
end
if K>2
    f=(f1-(tw/2))/fs;
else

f=(f1+(tw/2))/fs;
end
twn=tw/fs;
if H==1
if a<=21
    b=0;
elseif a>21&&a<50
    b=.5842*(a-21)^.4+.07886*(a-21);
elseif a>=50
    b=.1102*(a-8.7);
end

N=ceil((a-7.95)/(14.36*twn));
P=6;
else

  if (H==3&&a>21)||(H==3&&a>44)||(H==5&&a>53)||(H==6&&a>75)
        errordlg('Specifications cant be achieved by selected window!','FIR ERROR');
    else
        
        
    if (H==2&&a<=21)||(H==3)==1
        N=ceil(.9/twn);
        P=1;
    elseif (H==2&&(a>21&&a<=44))||(H==4)==1
        N=ceil(3.3/twn);
    P=2;
    elseif (H==2&&(a>44&&a<=53))||(H==5)==1
        N=ceil(3.5/twn );
      P=3;
    elseif (H==2&&(a>53&&a<=75))||(H==6)==1
        N=ceil(5.5/twn);
        P=5;
    elseif (H==2&&a>75)||(H==7)==1
        N=ceil(5.71/twn);
        b=8.96;
        P=6;
    end
  end
end  
    
    
if N/2==ceil(N/2)
    N=N+1;
end
w=2*pi*f;
n=(N-1)/2;

for i=-n:n
    if K==1
    hd(i+n+1)=2*f*sin(w*i)/(w*i);
    hd(n+1)=2*f;
    
    elseif K==2
    hd(i+n+1)=-2*f*sin(w*i)/(w*i);
    hd(n+1)=1-2*f;
        
    elseif K==3
    hd(i+n+1)=2*f2*sin(w2*i)/(w2*i)-(2*f*sin(w*i)/(w*i));
    hd(n+1)=2*(f2-f);

    else
    hd(i+n+1)=2*f*sin(w*i)/(w*i)-(2*f2*sin(w2*i)/(w2*i));
    hd(n+1)=1-2*(f2-f);
    end
end

for i= -n:n
    
            if P==1
                    r(i+n+1)=1;
W=('Window used : rectangular');
            else if P==2
                     r(i+n+1)=.5+.5*cos(2*pi*i/(N-1));
W=('Window used : hann');
            else if P==3
                     r(i+n+1)=.54+.46*cos(2*pi*i/(N-1));
W=('Window used : hamming');
            else if P==5
                     r(i+n+1)=.42+.5*cos(2*pi*i/(N-1))+.08*cos(4*pi*i/(N-1));
           W=('Window used : blackman');
            else  if P==6
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                     W=('Window used : kaiser');
             
                      end
                   end
                end
            end
        end
end

disp(W);
c=r.*hd;
figure(1)
stem(c)
y=fft(c,fs);
j=20*log10(abs(y/max(y)));
figure(2)
plot(j(1:fs/2));xlabel('Frequency (Hz)');ylabel('Magnitude Response (dB)');
grid on;
end