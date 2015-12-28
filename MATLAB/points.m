function y=points(dp,ds,twn)

y=ceil(((log10(ds))*(.005309*(log10(dp))^2+.07114*log10(dp)-.4761)-.00266*(log10(dp))^2-.5941*log10(dp)-.4278)/twn - twn*(11.01217+.51244*(log10(dp)-log10(ds)))+1);
