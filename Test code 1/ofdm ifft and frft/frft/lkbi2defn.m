function t = lkbi2defn(yp)
  mlen=length(yp);      
t=0;
k=1;
for i=0:mlen-1
    yp1=fliplr(yp);
   t=t+yp1(k)*(2^i);
   k=k+1;
end
