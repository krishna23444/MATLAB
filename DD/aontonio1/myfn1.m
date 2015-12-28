function D=myfn1(al)

load('F:\Users\JC\Documents\h.mat');
h=imag(Expression1);

load('F:\Users\JC\Documents\v.mat');
v=Expression1;
load('F:\Users\JC\Documents\k.mat');
k=Expression1;
hf=kaiser(length(h),al).*h;

gh=max(abs(hf(:)));
loc=find(abs(hf(:))==gh);
    if mod(v,2)==0
    
hf(loc)=hf(loc)-sum(hf(:));
    else

hf(loc(1))=hf(loc(1))-sum(hf(:))/2;
hf(loc(2))=hf(loc(2))-sum(hf(:))/2;
    end
    
omegap=k*pi;

S2=2^16;

L=1;
p=0
q=1;
for i=ceil(k*p*S2):ceil(k*S2)
d(q)=(((pi)/S2)*i)^v;
q=q+1;
end
 
%        [cc,vv]=freqz(hf,1,[0 .8]);

       

    [y,P]=freqz(hf,1,linspace(0,pi,S2));
        y1=abs(y);
%         -abs(cc(1));


   for i=1:S2*k
        e(i)=abs(y1(i)-d(i));
   end
       
    D=max(e);
   
