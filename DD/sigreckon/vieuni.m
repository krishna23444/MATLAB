clc
clear all
% close all
% format long G
% load('D:\MATLAB 2010 Portable\bin\DD\UNIPEN-DTW.mat');
% xx=round(100*D{1,1});
% yy=round(100*D{1,2});
% x=xx(1,:);
% y=yy(1,:);
%w1j
xx=[433  497;
 433  497;
 433  497;
 433  497;
 390  493;
 390  493;
 390  493;
 335  551;
 335  551;
 279  620;
 249  664;
 222  709;
 197  754;
 175  800;
 163  848;
 159  897;
 164  944;
 177  989;
 177  989;
 220 1054;
 220 1054;
 279 1091;
 279 1091;
 344 1076;
 344 1076;
 404 1007;
 429  960;
 451  902;
 468  835;
 478  766;
 484  692;
 486  630;
 483  574;
 478  532;
 478  532;
 464  481;
 464  481;
 464  481;
 449  547;
 448  598;
 448  655;
 448  722;
 451  791;
 455  860;
 460  924;
 464  980;
 470 1023;
 477 1064;
 477 1064;
 503 1118;
 503 1118;
 503 1118;
 566 1126;
 566 1126;
 619 1091;
 619 1091;
 676 1019;
 676 1019;
 725  933;
 725  933];

x=xx(:,1)-min(xx(:,1))+1;
y=xx(:,2)-min(xx(:,2))+1;


b=zeros(max(x)+1,max(y)+1);
for c=1:length(x)
    for a=1:length(x)
    b(y(a),x(c))=1;
    end
end


