clc;
clc;
clear all;


clc;

clear all;
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



disp ('THE CORRESPONDING WEIGHT IS : ')
disp(w(:,i+1))

end
  

