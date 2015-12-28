function data_rx=lkchannelfn(data_tx,snr,ch1)
switch(ch1)
    case 1
        data_rx = awgn(data_tx,snr,'measured');
    case 2
        ch = rayleighchan(1/10000, 10, 0 ,0); 
            ch.ResetBeforeFiltering = 0;
            fad = abs(filter(ch, data_tx));
            fadedSig = fad.*data_tx;
            data_rx = awgn(fadedSig,snr,'measured',53);
end
end
