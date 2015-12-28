function res=fun(x) 
s=size(x)
for i=1:s(1)
    for j=1:s(2)
        
    
res(i,j)= sin(x(i,j))+cos(x(i,j))
    end
end

