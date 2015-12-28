clc
clear all
o=input('enter the sequence');
l=input('enter the length of Lempel Ziv code');
v=1;
for j=1:length(o)/l
    for i=1:l    
         c(j,i)=o(v);
         v=v+1;
    end
end
a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
for i=1:length(o)/l
    y(i+2)=[strcat(y(bin2dec(num2str(c(i,1:(l-1))))),(num2str(c(i,l))))];
end
y(:,1:2)=[];
cellplot(y);
celldisp(y)
    





