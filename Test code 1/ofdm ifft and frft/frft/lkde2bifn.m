function b23 = lkde2bifn(ipdeMod,m)

len=length(ipdeMod);

for i=1:log2(m)
    b(i)=mod(ipdeMod,2);
    ipdeMod=floor(ipdeMod/2);
b1=rot90(b);
b23=rot90(b1);

end

b2=b23;

end


