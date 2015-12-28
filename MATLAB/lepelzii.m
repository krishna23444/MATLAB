clc
clear all
%Lempel Ziv encoder

O=input('enter the sequence');

g=size(O);
for n=1:g(2)
    
 o(n)=str2num(O(n));
end
o;
%[0 0 0 1 0 1 1 1 0 0 1 0 1 0 0 1 0 1]
%[0 1 1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 0 1 1 0 0 1 1 1]
a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
q(1)={t};
q(2)={u};

p=1;
j=3;

while p<=length(o)

i=1;
a=1;

while (a~=0)
i=i+1;
a=strmatch(num2str(o(p:(p+i-1))),y,'exact');
end

y(j)={num2str(o(p:(p+i-1)))};

t=strmatch(num2str(o(p:(p+i-2))),y,'exact');;
b=dec2bin(t);
q(j)={strcat(num2str(b),num2str(o(p+i-1)))};

I=cell2mat(cellfun(@size,q,'UniformOutput',0))
l=max(I)
p=p+i;
j=j+1;
end
clear y q b a p j i I t u
a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
q(1)={t};
q(2)={u};
p=1;
j=3;
o
while p<=length(o)

i=1;
a=1;

while (a~=0)
i=i+1;
a=strmatch(num2str(o(p:(p+i-1))),y,'exact');
end

y(j)={num2str(o(p:(p+i-1)))};

t=strmatch(num2str(o(p:(p+i-2))),y,'exact');;
b=dec2bin(t);
q(j)={strcat(num2str(b),num2str(o(p+i-1)))};
s=size(q{j});
q(j)={strcat(num2str(zeros(1,l-s(2))),num2str(b),num2str(o(p+i-1)))};
p=p+i;
j=j+1;
end
y(:,1:2)=[]
q(:,1:2)=[]

P=strread(cell2mat(q),'%s').';
encod=cell2mat(P)
 
%%
 %Lempel Ziv Decoder
 v=1;
for j=1:length(encod)/l
    for i=1:l    
         c(j,i)=encod(v);
         v=v+1;
    end
end
a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
for i=1:length(encod)/l
    y(i+2)=[strcat(y(bin2dec(num2str(c(i,1:(l-1))))),(num2str(c(i,l))))];
end
y(:,1:2)=[];
    
    r=strread(cell2mat(y),'%s').';
W=cell2mat(r)
    
    
    
    

