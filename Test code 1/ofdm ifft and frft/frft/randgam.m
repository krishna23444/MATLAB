function value1=randgam(shape,w,data_txlen)
value1=gamrnd(shape,w/shape,[data_txlen 1]);
number=[data_txlen];
save(strcat('gamrandom',num2str(number),'.mat'),'value1');