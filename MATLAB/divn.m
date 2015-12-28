function y=divn(x)
%function used to find DFT of a sequence of length M^2 by divide and
%conquer method M X M

s=sqrt(length(x));


v=1;

for j=1:s
    for i=1:s    
         h(j,i)=x(v);
         v=v+1;
    end
end

 
    for i=1:s
     b(:,i) =w(s)*h(:,i);
    end
 
 o= w(length(x));
 
 for i=1:s
     for f=1:s
       g(i,f) = o(i,f)*b(i,f);
     end
 end
 
 for i=1:s
     k(i,:) =g(i,:)*w(s);
 end
 
 y=k(:).';