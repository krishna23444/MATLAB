clc
 clear all
format long g
n=[zeros(1,50) randn(1,5000)];
b=0.45;
for k=51:length(n)
    con=0;
    for l=1:50
    
    bm=1;
        
            bn=(0:l-1)+b;
            for m=1:length(bn)
                bm=bm*bn(m);
            end
             
            con=con+(-1^l)*bm*n(k-l)/factorial(l);
    end
    r(k-50)=n(k)+con;
    
end
