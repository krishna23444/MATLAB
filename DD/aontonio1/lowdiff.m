
function h = lowdiff(K,L)
% h = lowdiff(K,L)
% Maximally flat FIR lowpass differentiator (Type-III and IV)
% 1) K zeros at z = -1
% 2) 1 zero at z = 1
% 3) 2L zeros away from z = -1 and z = 1
% 4) length(h) = K+2L+2
%
% % Example
% K = 7;  L = 5;   
% h = lowdiff(K,L);
% [H,w] = freqz(h);
% plot(w/pi,abs(H));

% Ivan Selesnick, Polytechnic University, Brooklyn, NY
% selesi@taco.poly.edu
% January 2001

c(0+1) = 2;
c(1+1) = K+1/3;
for n = 2:L
   c(n+1) = ((-K+4*K*n-10*n+3+8*n^2)*c(n-1+1)-(2*n+K-3)^2*c(n-2+1))/(2*n*(2*n+1));
end

q = 1;
h = c(1);
for n = 1:L
   q = conv(q,[-1 2 -1]/4);
   h = [0 h 0] + c(n+1)*q;
end

for k = 1:K
   h = conv(h,[1 1]/2);
end
h = conv(h,[1 -1]/2);

