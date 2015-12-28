% fixed-freq source

function z=source(f,dx,dy,amp,phase,x,y,alpha)
R=((x-dx).^2 + (y-dy).^2).^0.5;

z = amp*cos(2*pi*f.*R + phase);

z = exp(alpha * -R) .* z;