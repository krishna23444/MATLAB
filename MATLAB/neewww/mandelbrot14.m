function mandelbrot14(any)
% Mandelbrot set v0.14
% Sai Wing Man 05/09/2006
% RUN: ’mandelbrot14(1)’ first to get the axes, then’mandelbrot14’ (no argin) after..
% .. but first zooming in using the zoom tool.
% I don’t ever intend to update this file.
%{
Copyright (C) 2006 Sai Wing Man
95
Essential MATLAB for Engineers and Scientists
This program is free software; you can redistribute it
and/or modify it under the terms of the GNU General
Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your
option) any later version.
This program is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License
for more details.
You should have received a copy of the GNU General Public
License along with this program; if not, write to the
Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA.
%}
tic
if nargin==1
%default axes
x0=-2;x1=0.5;y0=-1;y1=1;
axis([x0 x1 y0 y1])
end
k=axis; x0=k(1); x1=k(2); y0=k(3); y1=k(4);
clc
clf
num=440;
[x,y]=meshgrid(x0:(x1-x0)/(num-1):x1, (y0:(y1-y0)/(num-1):y1)*i);
c=x+y;
z=zeros(num,num);
jvec=5:30:500;
jindex=1;
cmap=colormap(hsv(length(jvec)));
hold on
for j=1:max(jvec)
z=z.^2+c;
if jvec(jindex)==j
if jindex<length(jvec)
plot(real(~isnan(z).*c),imag(~isnan(z).*c),'.', ...
'Markersize',0.5,'Color',cmap(jindex,:))
end
clc
jindex=jindex+1;
perc=j/max(jvec)*100/2+(jindex-2)/length(jvec)*100/2;

disp([int2str(perc)])
end
end
    
plot(real(~isnan(z).*c),imag(~isnan(z).*c),'.','Markersize',0.5,'Color',[0 0 0])
axis([x0 x1 y0 y1])
clc
toc