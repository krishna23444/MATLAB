function [ipMod,m] = modulationlkfn(yopi,chm)

switch(chm) 

    case 1
   nlen=length(yopi);
        mlen=length(yopi);    
m=512%input('enter the value of M = ');
if log2(m)~= floor(log2(m))
    error('Please check the value of m that you have provided for type M-PSK.');
end
kq=1;   
ml=log2(m);
            if mod(nlen,ml)==0
                len=nlen;
            else
               while mod(mlen,ml)~=0
                mlen=mlen+1;
              len=mlen;
               end
            end
 yopi=[yopi zeros(1,len-nlen)];
            len;
            slen=len/ml;
            mq=0;
            w=zeros(1,slen);
            for sq=1:slen
                if(mq<=len-(ml-1))
                    for yl=1:ml
                        yp(yl)=yopi(mq+1);
                        mq=mq+1;
                    end   
    t=lkbi2defn(yp); 
w(sq)= exp(2*pi*t*(m-1)/m*(-j));

            end      
            end
           ipMod = w;
           
   case 2
        
         nlen=length(yopi);
        mlen=length(yopi);    
m=input('enter the value of M = ');

if log2(m)~= floor(log2(m))
    error('Please check the value of m that you have provided for type M-PSK.');
end
kq=1;   
ml=log2(m);
            if mod(nlen,ml)==0
                len=nlen;
            else
               while mod(mlen,ml)~=0
                mlen=mlen+1;
              len=mlen;
               end
            end
 yopi=[yopi zeros(1,len-nlen)];
            len;
            slen=len/ml;
            mq=0;
            w=zeros(1,slen);
            for sq=1:slen
                if(mq<=len-(ml-1))
                    for yl=1:ml
                        yp(yl)=yopi(mq+1);
                        mq=mq+1;
                    end   
    t=lkbi2defn(yp); 
 k = sqrt(m);
r = 2*(0:k-1) - k + 1;
[xi, yi] = meshgrid(r);
c = xi + j*flipud(yi);
w(sq) = c(t+1);
                end
            end
            ipMod=w;
end
end
