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
e = 0;
for j = 1:c(1,2)
   
    for i = 1: c(1,2)

    net = (w(:,i)')*y(:,j);
   
    op = (2 / (1 + exp(-net) )) - 1 ;
    
        wcal = w(:,i) + (((1-(op^2))*(d(i,j)-op)*y(:,j))/2);
        

%     e = ((d(i,j)-op)^2)/2 + e
    sprintf('The corresponding updated matrix is w%d ', i )
    disp(wcal)  

z = horzcat(z,wcal);
    end
    w = z;
    z = [];

end
    
    