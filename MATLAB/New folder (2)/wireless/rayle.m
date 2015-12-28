clc
clear all
for sig=.5:.5:2
i=1;
for x=0:.1:10
u(i)=(x*exp((-x^2)/(2*sig^2)))/sig^2;
i=i+1;
end
plot(u);
hold on

end
