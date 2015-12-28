function y=myfn(al)
load('F:\Users\JC\Documents\v.mat')
v=Expression1;
if v~=1
        errordlg('this script is for first order DD ','DD ERROR');
    else
load('F:\Users\JC\Documents\h.mat');
hf=imag(Expression1);
h=kaiser(length(hf),al).*hf;
load('F:\Users\JC\Documents\k.mat');
k=Expression1;
omegap=k*pi;
m=omegap/pi;
S2=2^16;

L=1;
p=0;
q=1;
for i=ceil(m*p*S2):ceil(m*S2)
d(q)=(pi/S2)*i;
q=q+1;
end
       
   AA=ceil(m*S2)-ceil(m*p*S2)+1;
    [y,P]=freqz(h,1,linspace(p*omegap,omegap,AA));
    
     
    y=abs(y);

   for i=1:AA
        e(i)=abs(y(i)-d(i));
   end
       
    y=max(e);
   

end