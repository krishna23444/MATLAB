clc;clear;close all;

% for num=[4 10 14 20]
for num=15
figure
% for alp=-0.5:.1:-.2
for alp=-.3

bb=1;

for kk=2:num
bb(kk)=((kk-1)-alp-1)*bb(kk-1)/(kk-1);
end

imp=[-fliplr(bb(2:num)).*blackman(num-1).' 1 bb(2:num).*blackman(num-1).'];
[x y]=freqz(imp);

plot(abs(x)-1,'k','Linewidth',1.5);grid on;box on;hold on;title(strcat('filter length ::',num2str(length(imp))))
end

end
set(1,'color','w');

