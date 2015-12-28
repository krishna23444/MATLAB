clc
clear all
%Lempel Ziv encoder

O=input('enter','s');
X=dec2bin(double(O))
S=size(X)
e=1
for i=1:S(1)
    for j=1:S(2)
        o(e)=X(i,j);
        e=e+1;
    end
end
 
        l=input('enter the length of Lempel Ziv code');
% g=size(O);
% for n=1:g(2)
%     
%  o(n)=str2num(O(n));
% end
% o;
%[0 0 0 1 0 1 1 1 0 0 1 0 1 0 0 1 0 1]
%011011100011110010101101100111

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
s=size(q{j});
q(j)={strcat(num2str(zeros(1,l-s(2))),num2str(b),num2str(o(p+i-1)))};
p=p+i;
j=j+1;
end
y(:,1:2)=[]
q(:,1:2)=[]

P=strread(cell2mat(q),'%s').';
encod=cell2mat(P)
g=size(encod);

for n=1:g(2)
    
 H(n)=str2num(encod(n));
end
 
%%
 %Lempel Ziv Decoder
 v=1;
for j=1:length(H)/l
    for i=1:l    
         c(j,i)=H(v);
         v=v+1;
    end
end

A='0';
B='1';
T=strcat(A);
U=strcat(B);
Y(1)={T};
Y(2)={U};
for i=1:length(H)/l
    Y(i+2)=[strcat(Y(bin2dec(num2str(c(i,1:(l-1))))),(num2str(c(i,l))))];
end
Y(:,1:2)=[]
    
R=strread(cell2mat(Y),'%s').';
decod=cell2mat(R)
    
    
    
    

