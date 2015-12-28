clc;
clear all;
% x = input('Enter input matrix  :' )
% d = input('Enter teacher signal matrix  :')

k = 0;

while k ~= 5
    
    k = menu('FOR SELESCTION OF THE FOLLOWING TRAINING ALGORITHM PRESS BUTTON' , '        SINGLE LAYER DISCRETE PERCEPTRON TRAINING ALGORITHM', '        SINGLE LAYER CONTINOUS PERCEPTRON TRAINING ALGORITHM','        R-CATEGORY DISCRETE PERCEPTRON TRAINING ALGORITHM','            MULTICATEGORY CONTINOUS PERCEPTRON TRAINING ALGORITHM','                            QUIT');
 
if k==1
x = [1 -.5 3 -2 ];
d = [1 -1 1 -1];
w = [-2.5 1.75];
err = 0;
y = [];
z = [];
c = 1;
for i=1:length(x)
    
    z = vertcat(x(i),1);
    y = horzcat(y,z);  
    
end
disp(y)

for i=1:4
    
    y1 = y(1,i);
    y2 = y(2,i);
    ym = vertcat(y1,y2);
    op = w*ym;
   
    if op > 1
        
        op = 1;
    else
        op = -1;
    end
    
        w = w' + (((d(1,i)-op)*c*ym)/2);
        
     sprintf ('THE CORRESPONDING WEIGHT IS W%d ',i+1)
     disp(w)
        
        w = w';
        
%         err = (((d(i)-op)^2)/2)+err
        
%         if err == 0
%             return
        
% end
end
end
pause

if k==2
    
    x = [1 -.5 3 -2 ];
d = [1 -1 1 -1];
w = [-2.5 1.75];
eta = 1;
y = [];
z = [];

for i=1:length(x)
    
    z = vertcat(x(i),1);
    y = horzcat(y,z);  
    Emax = 1;
end
disp(y)

for i=1:4
    
    y1 = y(1,i);
    y2 = y(2,i);
    ym = vertcat(y1,y2);
    net = w*ym;
   
    op = (2 / (1 + exp(-net) )) - 1 ;
    
        w = w' + (((1-(op^2))*(d(1,i)-op)*eta*ym)/2);
        
     sprintf ('THE CORRESPONDING WEIGHT IS W%d ',i+1)
     disp(w)
        
        w = w'; 
        
    E = ((d(1,i)-op)^2)/2;
    sprintf ('THE CORRESPONDING WEIGHT IS E%d ',i+1)
    disp(E)
    if E < Emax
        disp('since Error calculated is less than Emax hence training terminates here.....');
        return;
    end
    
end
end
    pause;  
    
    if k==3
       
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

    wcal = w(:,i) + ((d(i,j)-op)*y(:,j)/2);
    sprintf('The corresponding updated matrix is w%d%d ', i,j )
    disp(wcal)  

z = horzcat(z,wcal);
    end
    w = z;
    z = [];

end
    
    end
    pause ;
    
    if k == 4
        
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
        
        sprintf('The corresponding updated matrix is w%d%d', j,i )
    disp(wcal)  

z = horzcat(z,wcal);
    end
    w = z;
    z = [];
end 
end
pause;
end;
