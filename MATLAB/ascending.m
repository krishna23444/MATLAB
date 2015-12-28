clear all

a=input('input elements');

for i=1:length(a)
    for j=i+1:length(a)
        if a(i)>a(j)
            temp=a(j);
            a(j)=a(i);
            a(i)=temp;
        end
        end
end
a

