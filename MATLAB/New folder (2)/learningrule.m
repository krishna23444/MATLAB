
clc;

clear all;

k = 0;

while k ~= 5
    
    k = menu('FOR SELESCTION OF THE FOLLOWING LEARNING RULES PRESS BUTTON' , '        HEBBIAN LEARNING RULE', '        PERCEPTRON LEARNING RULE','        DELTA LEARNING RULE','        WIDROW-HOFF LEARNING RULE','        QUIT');
    
      
    
%%


if k == 1

    w(:,1) = [1 ;-1 ; 0 ; .5];
x(:,1) = [1 ;-2 ;1.5 ;0];
x(:,2) = [1 ;-.5 ;-2 ;-1.5];
x(:,3) = [0 ; 1 ; -1 ; 1.5];

for i = 1 : 3
    
net = w(:,i)' * x(:,i);

if net > 0
    f = 1;
else 
        f = -1;
end

w(:,i+1) = w(:,i)+ (f * x(:,i));


sprintf ('THE CORRESPONDING WEIGHT IS W%d ',i)
disp(w(:,i+1))

end

pause


%%
    elseif k==2
        
    w(:,1) = [1 ;-1 ; 0 ; .5];
x(:,1) = [1 ;-2 ; 0 ; -1];
x(:,2) = [0 ;105 ;.5;1];
x(:,3) = [-1;1 ;.5 ;-1];
d = [-1;-1;1]


for i = 1 : 3
    
net = w(:,i)' * x(:,i);

if net > 0
    f = 1;
else 
        f = -1;
end

w(:,i+1) = w(:,i)+ 0.1*(d(i)-f) * x(:,i);



sprintf('The corresponding weight is : w%d ',i)
disp(w(:,i+1))

end
pause


%%
    elseif k==3
w(:,1) = [1 ;-1 ; 0 ; .5];
x(:,1) = [1 ;-2 ; 0 ; -1];
x(:,2) = [0 ;105 ;.5;1];
x(:,3) = [-1;1 ;.5 ;-1];
d = [-1;-1;1]


for i = 1 : 3
    
net = w(:,i)' * x(:,i);

if net > 0
    f = 1;
else 
        f = -1;
end

w(:,i+1) = w(:,i)+ 0.1*(d(i)-f) * x(:,i);




sprintf('The corresponding weight is : w%d ',i)
disp(w(:,i+1))

end

pause 
%%
    elseif  k == 4
        
        w(:,1) = [1 ;-1 ; 0 ; .5];
x(:,1) = [1 ;-2 ; 0 ; -1];
x(:,2) = [0 ;105 ;.5;1];
x(:,3) = [-1;1 ;.5 ;-1];
d = [-1;-1;1]

fnet = [];
fdashnet = [];
o = [];
for i = 1 : 3
    
net = w(:,i)' * x(:,i);


fnet(:,i) = (2 / (1 + exp(-net) )) - 1 ;

o(i) = fnet(:,i);

w(:,i+1) = w(:,i)+ 0.1*(d(i)-o(i))* x(:,i);


sprintf('The corresponding weight is : w%d ',i)
% disp ('THE CORRESPONDING WEIGHT IS : ')
disp(w(:,i+1))

end
       
pause

    end
    
end;


