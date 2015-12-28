clc
clear all
sig=1
for m=.5:.5:3
i=1;

for x=0:.1:10
u(i)=(x/sig^2)*I(m*x/sig^2)*exp(-(x^2+m^2)/2*sig^2);
i=i+1;
end
plot(u);
hold on

end

