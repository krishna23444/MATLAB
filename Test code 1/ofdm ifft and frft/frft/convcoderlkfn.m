function eop = convcoderlkfn(dip,ch)
switch(ch)
    case 1
  c=zeros(1,3);
   xipl=length(dip);
  for v=1:xipl
    c(1)=dip(v);
    b1(v)=xor(c(1),c(3));
    b2(v)=xor(c(1),c(2));
    b3(v)=xor(b2(v),c(3));
    c(3)=c(2);
    c(2)=c(1);
       
end
b3;
b1;
j=1;
h=1;
for l=1:2*xipl
    if(mod(l,2)~=0)
        eop(l)=b3(j);
        j=j+1;
    else
        eop(l)=b1(h);
        h=h+1;
    end
end

    case 2
cod=zeros(1,3);
xipl=length(dip);
for v=1:xipl
    if (v<=xipl-v)
    cod(1)=dip(2*v-1);                        
    cod(2)=cod(1);
    
        o=2*v;
        cod(1)=dip(o);
    else
        break
    end
     b1(v)=xor(cod(1),cod(2));
    b2(v)=xor(cod(1),cod(3));
    b3(v)=xor(b1(v),cod(3));                 
    cod(3)=cod(1);
    
       
end
b1;                     
b2;
b3;                                         
j=1;
popc=length(b1);
h=1;
for l=1:popc
    eop(j)=b3(h);
        j=j+1;
           eop(j)=b2(h);
        j=j+1;
            eop(j)=b1(h);
        h=h+1;
        j=j+1;
end
    case 3
       
xipl=length(dip);
c=zeros(1,3);
for v=1:xipl
    if (v<=xipl-2*v)
    c(1)=dip(3*v-2);
    c(2)=c(1);
  c(3)=c(2);  
        o=2*v+v-1;
        c(1)=dip(o);
        c(2)=c(1);
        p=3*v;
        c(1)=dip(p);
    else
        break
    end
     b1(v)=xor(c(1),c(2));
    b2(v)=xor(c(1),c(3));
    b3(v)=xor(c(2),c(3));
    b4(v)=xor(b1(v),c(3));
    
    
       
end
b1;
b2;
b3;
b4;

j=1;
p=length(b1);
h=1;
for l=1:p
    eop(j)=b4(h);
        j=j+1;
           eop(j)=b3(h);
        j=j+1;
            eop(j)=b2(h);
        j=j+1;
        eop(j)=b1(h);
            h=h+1;
        j=j+1;
end
eop;
end
end
