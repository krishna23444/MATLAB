function y = w(x)

y=0;
for i = 1:x
    for f=1:x
        y(i,f)=exp(-j*(i-1)*(f-1)*2*pi/x);
    end
end

        