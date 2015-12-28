function h=heightm(rangeMetres)
% HEIGHTM  Required antenna height in metres to achieve a given radar horizon
% h=heightm(rangeMetres)
% 
% TODO: Help
Rnm=rangeMetres/1852;
hfeet=(Rnm/1.23)^2;
h=hfeet*.3048;