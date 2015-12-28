clc
clear all
x=input('enter the sequence');
X(:,1)=x.';
r=input('enter radix');
N=length(x);
s=round(log10(N)/log10(r));
n=1;
for i=1:N/r
    for j=1:r
        y(i,j,2)=x(n);
        n=n+1;
    end
end
 for p=3:s
     h=0;
     for i=1:r
         for j=1:r^(p-3)
             z=y(((j-1)*r^(s-p+2)+1):(j*r^(s-p+2)),i,p-1);
             h=h+1;
             y((h-1)*r^(s-p+1)+1:h*r^(s-p+1),:,p)=reshape(z,r,r^(s-p+1)).';
         end
     end
 end
h=1;
for m=1:r
 for l=1:r^(s-2)
            y((l-1)*r+1:l*r,m,s)=fft(y((l-1)*r+1:l*r,m,s));
            w(h,:)=y((l-1)*r+1:l*r,m,s);
                
            h=h+1;
        end
 end
             X(:,2)=w(:)
 y
 d=3;
for i=s:-1:2
clear w   
     for l=1:r^(i-2)
             q=y((l-1)*r^(s-i+1)+1:l*r^(s-i+1),:,i);
              for j=1:r
                   for k=1:r^(s-i+1)
                       q(k,j)=twid(k-1,j-1,r^(s-i+2)).*q(k,j);
                   end
               end
               y((l-1)*r^(s-i+1)+1:l*r^(s-i+1),:,i)=q;
     end
     y
    h=1;
for m=1:r
        for l=1:r^(i-2)
            
            w(h,:)=y((l-1)*r^(s-i+1)+1:l*r^(s-i+1),m,i)
                
            h=h+1;
        end
 end
X(:,d)=w(:)
    
    for l=1:r^(s-1)
        y(l,:,i)=fft(y(l,:,i));
        
    end
    
    h=1;
    if i==2
        q=y(:,:,i);
        X(:,d+1)=q(:);
    else
    for J=1:r
        for l=1:r^(i-3)
          q=y((h-1)*r^(s-i+1)+1:h*r^(s-i+1),:,i);
          y(((l-1)*r^(s-i+1+1)+1):(l*r^(s-i+1+1)),J,i-1)=q(:);
           h=h+1;
        end
   end
    end
    d=d+1;
end
