clc;
clear all;
d = [1,-1,-1;-1,1,-1;-1,-1,1]'
w = [1,-2,0;0,-1,2;1,3,-1]'
y = [10,2,-5;2,-5,5];
c = size(y);
x = -1*ones(1,c(1,2));
y = vertcat(y,x)
wcal = [];
wcalc = [];
z = [];
for j = 1:c(1,2)
   
    for i = 1: c(1,2)
        opm = (w(:,i)')*y(:,j);
    if opm > 1
        op = 1;
    else op = -1;
    end
%     disp(op)
    wcal = w(:,i) + ((d(i,j)-op)*y(:,j)/2);
    sprintf('The corresponding updated matrix is w%d ', i )
    disp(wcal)  

z = horzcat(z,wcal);
    end
    w = z;
    z = [];

end
    
    