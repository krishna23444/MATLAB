function val=window(i,tipo,p)

%gaussian weighting
if(strcmp(tipo,'gaus')==1)
    val=(1/(p*sqrt(2*pi)))*exp(-(i.^2)/(2*p^2));
 
%constant weighting
elseif(strcmp(tipo,'rect')==1)
    val=p*ones(1,size(i,2));
end

% normalize
val=val./max(val);
