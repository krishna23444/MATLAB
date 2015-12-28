function fnet = contionousfunction(y)

    y1 = y(1,i);
    y2 = y(2,i);
    ym = vertcat(y1,y2);
    net = w*ym;
   
    fnet = (2 / (1 + exp(-net) )) - 1 ;
