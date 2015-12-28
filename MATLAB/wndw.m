function c=wndw(f1,a,fs,tw,dp,ds)
K=1;
H=1;
f=(f1+(tw/2))/fs;
if -20*log10(min(dp,ds))>a & dp~=0 & ds~=0
    a=-20*log10(min(dp,ds));
end


twn=tw/fs;

if a<=21
    b=0;
elseif a>21&&a<50
    b=.5842*(a-21)^.4+.07886*(a-21);
elseif a>=50
    b=.1102*(a-8.7);
end

N=ceil((a-7.95)/(14.36*twn));
P=6;
    
    
if N/2==ceil(N/2)
    N=N+1;
end
w=2*pi*f;
n=(N-1)/2;

for i=-n:n
   
    hd(i+n+1)=2*f*sin(w*i)/(w*i);
    hd(n+1)=2*f;
   
end

for i= -n:n
  
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                     W=('Window used : kaiser');
             
                      end

            
c=r.*hd;
