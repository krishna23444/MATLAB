function [data_rx h]= channellkfn(data_tx,snr,ch1)

data_txlen=length(data_tx);
    switch(ch1)
    case 1
             data_rx = awgn(data_tx,snr);

    case 2

%         n=1/sqrt(2)*[rand(1,data_txlen) + j*rand(1,data_txlen)];
        n=1/sqrt(2)*[randn(1,data_txlen) + j*randn(1,data_txlen)];
        h=abs(sqrt(0.5))*[rand(1,data_txlen) + j*rand(1,data_txlen)];
        fadedsig=h.*data_tx + 10^(-(snr)/20).*n;
        data_rx=fadedsig./h;

        case 3
        shape=0.37;
        w=5;
        h=1/sqrt(2)*(sqrt(gamrnd(shape,w/shape,[data_txlen 1]))+sqrt(gamrnd(shape,w/shape,[data_txlen 1])));
        n_len=length(h);
        %         n=1/sqrt(2)*[rand(1,data_txlen) + j*rand(1,data_txlen)];
        n=1/sqrt(2)*[randn(1,data_txlen) + j*randn(1,data_txlen)];
        fadedsig=h'.*data_tx + 10^(-(snr)/20).*n;
        data_rx=fadedsig./h';


        case 4
            
            %         n=1/sqrt(2)*[rand(1,data_txlen) + j*rand(1,data_txlen)];
        n=1/sqrt(2)*[randn(1,data_txlen) + j*randn(1,data_txlen)];
        h=abs(sqrt(0.5))*[normrnd(.5,1,1,data_txlen) + j*normrnd(.5,1,1,data_txlen)];
        fadedsig=h.*data_tx + 10^(-(snr)/20).*n;
        data_rx=fadedsig./h; 
            
            
    end
end
