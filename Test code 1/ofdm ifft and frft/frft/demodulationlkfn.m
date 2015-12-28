function data_demod= demodulationlkfn(ipfinal,chdm,m)

switch(chdm)  
       case 1
           ipdeMod = zeros(size(ipfinal));
%m=input('enter the value of M = ');
%now generating the cancellation points
t = (0:m-1);
c  = exp(2*pi*t*(m-1)/m*(-i)); % taking the concept of cosx + i*sinx
%scatterplot(c);
% Slicer: Find closest constellation symbol, symbol-by-symbol.
for k = 1:length(ipfinal)
    [nil ind] = min(abs(ipfinal(k) - c));
    ipdeMod(k) = ind-1;
   end
ipdeMod;
len=length(ipdeMod);
g=zeros(1,len*log2(m));
t=1;
for r=1:len
ipdeModfinal=lkde2bifn(ipdeMod(r),m);
d=ipdeModfinal;

g(t:t+log2(m)-1)=d;
t=t+log2(m);

end
data_demod=g;

    case 2
        
        k = sqrt(m);
r = 2*(0:k-1) - k + 1;
[xi, yi] = meshgrid(r);
c = xi + j*flipud(yi);
c = c(:);
ipdeMod = zeros(size(ipfinal));
for k = 1:length(ipfinal)
    [nil ind] = min(abs(ipfinal(k) - c));
    ipdeMod(k) = ind - 1;
end
ipdeMod;
len=length(ipdeMod);
g=zeros(1,len*log2(m));
t=1;
for r=1:len
ipdeModfinal=lkde2bifn(ipdeMod(r),m);
d=ipdeModfinal;

g(t:t+log2(m)-1)=d;
t=t+log2(m);

end
data_demod=g;
end
end
