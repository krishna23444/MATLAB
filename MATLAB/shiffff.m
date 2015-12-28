clear all
P=3
N=21
n=10

for i= -n:n
    
            if P==1
                    r(i+n+1)=1;
W=('Window used : rectangular');
            else if P==2
                     r(i+n+1)=.5+.5*cos(2*pi*i/(N-1));
W=('Window used : hann');
            else if P==3
                     r(i+n+1)=.54+.46*cos(2*pi*i/(N-1));
W=('Window used : hamming');
            else if P==5
                     r(i+n+1)=.42+.5*cos(2*pi*i/(N-1))+.08*cos(4*pi*i/(N-1));
           W=('Window used : blackman');
            else  if P==6
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                     W=('Window used : kaiser')
                      end
                   end
                end
            end
        end
end

for z=-n:n
    for a=-n:n
       ab=sqrt((z^2)+(a^2)))
        gg(z+n+1,a+n+1)=r(ab+n+1)
    end
end
