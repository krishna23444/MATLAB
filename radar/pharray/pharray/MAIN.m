%
%
% Phased Array demo
% 
% You can generate any number of independent beams, each one with its own
% direction and focalization.
% 
% By Diglo, diglo@email.it
% 26 oct 2010

clc
clear all
close all

dim=1500;                       % sim. horiz. range
depth=3*dim;                    % sim. depth range
resolution=15;                  % sim. resolution (the smaller, the slower)

% beams' list: each vector element represents a beam

theta=[-5 24 -45];              % steering, degrees
focus=[0.0025 0.0030 0.00300];  % focus (low values -> far focus)
intensity=[1 1 1];              % relative intensity

N=128;                          % # of array elements
DIST=10;                        % distance between elements

focus=focus+DIST;               % focus correction
k=pi/DIST;                      % phase velocity
f=1/(2*DIST);                   % source frequency
F=size(theta,2);                % # of beams

intensity=intensity./max(intensity);

% simulation space
[x,y] = meshgrid(-dim:resolution:dim, 0:resolution:depth);
z=0;

if(mod(N,2)~=0)
    n=floor(N/2);
else
    n=(N-1)/2;
end

posx = (-n:n) * DIST;
amp=window(-n:n,'gaus',12*N/64);

% simulation core

% for each beam
for w=1:F
    h = waitbar(0,['Beam ' num2str(w) ' of ' num2str(F) ': ...']);
   
    % for each array element
    for i = 1:N
        if(amp(i)~=0)
            z = z + intensity(w) * source(f, posx(i),0 ,amp(i),phasing(posx(i),k, focus(w),(theta(w)/180)*pi),x,y,0.0003);
        end
        waitbar(i/N,h,['Beam ' num2str(w) ' of ' num2str(F) ': Element ' num2str(i) ' of ' num2str(N)])
    end
    close(h);
end

% log amplitude
z=10*log10(abs(z).^2+0.1);

scrsz = get(0,'ScreenSize');
fx=floor(2*dim/resolution);
fy=floor(depth/resolution);
figure('Position',[scrsz(3)/2-fx/2 scrsz(4)/2-fy/2  fx fy])

% plot 
imagesc(z);
colormap('gray');
axis off

hold on
SPAN=2*dim/resolution;
% plot array representation
for i= 1:N
    plot(posx(i)/resolution+SPAN/2,1,'r.');
    plot([posx(i)/resolution+SPAN/2,posx(i)/resolution+SPAN/2],[1,((SPAN)/8)*amp(i)],'g-');
end

% plot beam direction vectors
for i= 1:F
    plot([SPAN/2 , (SPAN)/6*sin( (theta(i)/180)*pi )+SPAN/2] , [0 , (SPAN)/6*cos( (theta(i)/180)*pi )],'b-');
end



