clc

x = [1 2 1];
h = [2 3 1 2];

y = zeros(1,length(x) + length(h) - 1);

for n = 1:length(y)
   sum = 0;
   for k = 1 : length(x)
       index = n - k + 1;
       if index >= 1 && index <= length(h)
           sum = sum + ( x(k) .* h(index) );   
       end
   end
   y(n) = sum;
end

subplot(2,2,1);
z = 1:1:length(x);
stem(z,x);
axis([1 length(x) 0 3])
title('x - Sequence','FONTSIZE',12); 
subplot(2,2,2);
z = 1:1:length(h);
stem(z,h);
axis([1 length(h) 0 4])
title('h - Sequence','FONTSIZE',12); 
z = 1:1:length(y);
subplot(2,2,3);
stem(z,y);
axis([1 length(y) 0 12])
title('Convolution using FOR loop','FONTSIZE',10); 
subplot(2,2,4);
stem(z,conv(x,h));
axis([1 length(y) 0 12])
title('Convolution using CONV function','FONTSIZE',10); 