clc
clear all

q=1;
for a=0:.005:1
    Fa=dFRT(501,a);
%      A=[10*ones(1,101) zeros(1,400)];
c=1;
    for i=0:.01:5
    A(c)=sin(i*pi);
    c=c+1;
    end
    ff(:,q)=A*Fa;
%     ff(q,:)=[hanning(51)' zeros(1,250)]*Fa;
%     plot(fftshift(20*log10(abs(ff(q,:))/max(abs(ff(q,:))))))
if a>=.1    

    surf(fftshift(abs(ff),1));
    colormap([1  1  0; 0  1  1])
    F(q)=getframe;
end
    q=q+1;
end


