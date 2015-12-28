clc
clear all
m=input('enter no. of neurons');
v=input('enter no. of inputs');
c=input('enter learning constant');

n=input('enter desired output');
l=input('enter lambda');
W=randn([v,m])
F=0

x=input('enter starting input matrix');    
for i=1:n 

    for j=1:m
    
       net(j)= sum(x'.*W(:,j))
       F(j)=actcon(net(j),l)

    end
       fm=max(F);    
       for k=1:m
           if F(k)==fm
               K=k;
           end
       end
           
       W(:,K)=W(:,K)+c*(x'-W(:,K))
end
W
    
    
