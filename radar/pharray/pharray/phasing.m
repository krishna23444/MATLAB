function t=phasing(posx,k,focus,ang)

%  focusing                  steering
t=((posx/focus).^2)*2*pi + posx.*k.*sin(ang);