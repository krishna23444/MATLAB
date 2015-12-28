function y=mindist(x,T)
for i=1:length(T)
    y1(i)=sqrt((real(x)-real(T(i)))^2+(imag(x)-imag(T(i)))^2);
end
y1=y1/min(y1);
y=find(y1==1);
