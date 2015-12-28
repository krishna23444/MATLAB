function Faf = frftrxlkfn (ipDemod1,a1)
% The fast Fractional Fourier Transform
% input: f = samples of the signal
%        a = fractional power
% output: Faf = fast Fractional Fourier transform
error(nargchk(2, 2, nargin));
f = ipDemod1(:);
N = length(f);
shft = rem((0:N-1)+fix(N/2),N)+1;
sN = sqrt(N);
a = mod(a1,4);
% do special cases
if (a==0), Faf = f; return; end;
if (a==2), Faf = flipud(f); return; end;
if (a==1), Faf(shft,1) = fft(f(shft))/sN; return; end 
if (a==3), Faf(shft,1) = ifft(f(shft))*sN; return; end
% reduce to interval 0.5 < a < 1.5
if (a>2.0), a = a-2; f = flipud(f); end
if (a>1.5), a = a-1; f(shft,1) = fft(f(shft))/sN; end
if (a<0.5), a = a+1; f(shft,1) = ifft(f(shft))*sN; end
% the general case for 0.5 < a < 1.5
alpha = a*pi/2;
tana2 = tan(alpha/2);
sina = sin(alpha);
f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)];
% chirp premultiplication
chrp = exp(-i*pi/N*tana2/4*(-2*N+2:2*N-2)'.^2);
f = chrp.*f;
% chirp convolution
c = pi/N/sina/4;
Faf = fconv(exp(i*c*(-(4*N-4):4*N-4)'.^2),f);
Faf = Faf(4*N-3:8*N-7)*sqrt(c/pi);
% chirp post multiplication
Faf = chrp.*Faf;
% normalizing constant
Faf = exp(-i*(1-a)*pi/4)*Faf(N:2:end-N+1);


end

