%function class1=getClassList(P)
% extracts the list of classes from the parameter structure P

function class1=getClassList(P)

N1=fieldnames(P);
count=1;
len=size(N1,1);count=1;
for i=1:len
  ind=findstr('_CLASS',char(N1{i}));
  if (isempty(ind)==0)
    class1{count}=getfield(P,N1{i});count=count+1;
  end
end

