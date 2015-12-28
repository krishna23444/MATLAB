function w = twiddlelkfn(len)
for p=1:len
    for q=1:len
        w(p,q)=exp((-j)*2*pi*(p-1)*(q-1)/len);
    end
end