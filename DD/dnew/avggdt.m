function y=avggdt(x)
c=size(x);
[xx yy]=gradient(x);
gc=0;
for ss=1:c(1)
for dd=1:c(2)
gc=gc+sqrt((xx(ss,dd).^2+yy(ss,dd).^2)./2);
end
end
y=gc/(c(1).*c(2));