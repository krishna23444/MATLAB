clc
clear all

dp=input('enter passband deviation');
ds=input('enter stopband deviation');
f1=input('enter Input sampling frequency');
f2=input('enter Output sampling frequency');
fp=input('enter frequency of interest(passband)');

com=input('enter the combination')


st=length(com);
% dp=10^(Dp/20)-1;ds=10^(Dp/20);
dp=dp/st
M=f1/f2

F=factor(M)
x(1,:)=[M 1]

for i=2:max(F)
     D=combnk(F,i)
     s=size(D)
     for k=1:s(1)
    
         for j=1:i
        
             x(i,:) = [(M/D(k,j)) D(k,j)]
         end
     end
end



ft=f1
for j=1:st
pat(j)=ft/com(j)
ft=pat(j)
end
pat=[f1 pat]

for i=1:st
    
    Fsbe(i)=pat(i+1)-(f1/(M*2))
    twn(i)=(Fsbe(i)-fp)/pat(i)
    N(i)=points(dp,ds,twn(i))

end
    
    TSR=sum(N)
    i=1:st;
    MPS=sum(N(i).*pat(i+1))
    


    
    