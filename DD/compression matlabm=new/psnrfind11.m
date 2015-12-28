
clc
clear all
ps=[39.12 ]
m=[];
for i=1:length(ps)
ms=255^2/(10^(ps(i)/10));
m=[m,ms]
end
