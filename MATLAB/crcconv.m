clc
clear all

x=input('enter the sequence');
y=input('enter the sequence no. 2');
if length(x)>length(y)
    y=[y zeros(1,length(x)-length(y))]
    for i=1:length(x)
    x1(:,i)=circshift(x.',i-1);
end

elseif length(x)<length(y)
x=[x zeros(1,length(y)-length(x))]
for i=1:length(y)
    x1(:,i)=circshift(y.',i-1);
end

end

out=y*x1