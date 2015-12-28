x=input('enter 1 for distance and 2 for energy');
v=input('enter N0');
if x=1
  d=input('enter distance');
  ans=3*(erfc(d/sqrt(v*1.414)))-(erfc(d/sqrt(v*1.414)))^2*2.25;
  disp('the Prob of error is'),disp(ans);
else
    d=input('enter energy');
    ans=3*(erfc(sqrt(d/v*5)))-(erfc(sqrt(d/v*5)))^2*2.25;
    disp('the Prob of error is'),disp(ans);
end