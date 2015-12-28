% Copyright (c) 2001, Shelby Pereira, University of Geneva
% 
%  Permission to use, copy, modify, and distribute this software and its
%  documentation for any non-commercial purpose and without fee is hereby
%  granted (GPL), provided that the above copyright notice appear in all
%  copies and that both that copyright notice and this permission notice
% appear in supporting documentation. This software is provided "as is" 
% without express or implied warranty. The authors shall not be held
% liable in any event for incidental or consequential damages in
% connection with, or arising out of, the furnishing, performance, or
% use of this program.
% 
% If you use the Checkmark software package for your research, please cite:
%
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madueño, Stéphane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
% P.param1 is the angle of rotation
% P.param2 is the axis of rotation
% axis is 1 for the x_axis or 2 for the y_axis (rotation)
% set to 3 for a sphere 
% set to 4 for cylinder x-axis
% set to 5 for cylinder y-axis
% axis = 3,4,5 are use for modelling video distortion
% P.param3 is the radius (distance to the axis of rotation
% P.param4 is a scaling parameter increase to increase distortions

function imout=CM_projective(P,imin,Zcord)
%function imout=projective(imin,angle1,axis1,distfac,Zcord)
% assumes the midpoint of the image is at 0,0,distfac

% angle is in degrees
angle1=P.param1;
axis1=P.param2;
distfac=P.param3;
radiusfac=P.param4;

if exist('distfac')~=1
  distfac=1;
end
angrad=(pi/180)*angle1;
[m,n]=size(imin);
dist=max([m n])*distfac;
%dist=distfac;
if exist('Zcord')~=1
  Zcord=dist*ones(m,n);
end

radius=radiusfac*max([m n]);
%  radiusfac=2; % decrease to increase distortions


% assign x and y axes to the image
min1=-floor(m/2);max1=min1+m-1;vecy=min1:max1;
min1=-floor(n/2);max1=min1+n-1;vecx=min1:max1;

tmat=[cos(angrad) sin(angrad);-sin(angrad) cos(angrad)];
newvals=zeros(m*n,3); %to store the newx, newy and z values before

% interpolation
switch axis1
 case 1 
  % rotation around xaxis so xcoordinates are constant
  % compute the transformed coordinates
  count=1;newvals=[];
  len1=size(Zcord,2);
  for i=1:m
    vecy2=vecy(i)*ones(1,len1);
    coord2=[Zcord(i,:);vecy2];
    tcord=tmat*coord2;
    projFactors=tcord(1,:)/dist;
    newvals=[newvals;[vecx'./projFactors',tcord(2,:)'./projFactors',imin(i,:)']];
  end

 case 2, % rotation about y axis

  count=1;newvals=[];
  len1=size(Zcord,2);
  for i=1:m
    coord2=[Zcord(i,:);vecx]; 
    tcord=tmat*coord2;
    projFactors=tcord(1,:)/dist;
    newvals=[newvals;[tcord(2,:)'./projFactors',vecy(i)./projFactors',imin(i,:)']];
  end
 
 case 3, % sphere
    count=1;rad2=radius*radius;
  for i=1:m
    for j=1:n
      Zcord(i,j)=sqrt(rad2- vecx(j)*vecx(j)-vecy(i)*vecy(i));
    end
  end 
  projFactor=Zcord./dist;newvals=[];
  for i=1:m
    newvals=[newvals;[[vecx./projFactor(i,:)]',[vecy(i)./projFactor(i,:)]',imin(i,:)']];
  end
  
 case 4, % cylinder x-axis
  count=1;rad2=radius*radius;  
  for i=1:m
    for j=1:n
      Zcord(i,j)=sqrt(rad2-vecy(i)*vecy(i));
    end
  end 
  projFactor=Zcord./dist;newvals=[];
  for i=1:m
    newvals=[newvals;[[vecx./projFactor(i,:)]',[vecy(i)./projFactor(i,:)]',imin(i,:)']];
  end
  
 case 5, % cylinder y-axis
  count=1;rad2=radius*radius;
  for i=1:m
    for j=1:n
      Zcord(i,j)=sqrt(rad2- vecx(j)*vecx(j));
    end
  end 
  projFactor=Zcord./dist;newvals=[];
  for i=1:m
    newvals=[newvals;[[vecx./projFactor(i,:)]',[vecy(i)./projFactor(i,:)]',imin(i,:)']];
  end
  
 case 6, % arbitrary Z coordinates, by default
  projFactor=Zcord./dist;newvals=[];
  for i=1:m
    newvals=[newvals;[[vecx./projFactor(i,:)]',[vecy(i)./projFactor(i,:)]',imin(i,:)']];
  end
 case 7, % arbitrary Z coordinates, x and y also
  xDistortion=P.param5; %a matrix containing the shift for each x point on the grid
  yDistortion=P.param6;%a matrix containing the shift for each Y point on the grid
  projFactor=Zcord./dist;newvals=[];
  newvals=zeros(m*n,3);count=1;
  for i=1:m
    for j=1:n
      xval=vecx(j)+xDistortion(i,j);
      yval=vecy(i)+yDistortion(i,j);
      newvals(count,:)=[xval/projFactor(i,j),yval/projFactor(i,j),imin(i,j)];
      count=count+1;
    end
  end
end



% find the dimensions of the new image
minx=floor(min(newvals(:,1)));  maxx=ceil(max(newvals(:,1)));
miny=floor(min(newvals(:,2)));  maxy=ceil(max(newvals(:,2)));
%[minx,maxx,miny,maxy]

%interpolate
[xti,yti]=meshgrid(minx:maxx,miny:maxy);
imout=griddata(newvals(:,1),newvals(:,2),newvals(:,3),xti,yti);

% crop out a small area border to eliminate most of the black
% stuff
bandsize=3;
imout=bandcrop(imout,bandsize);
imout=killnan(imout);

% if we are modelling video distortions we should resize to the original image size
switch  axis1
  case {3,4,5} 
   imout=imresize(imout,[m n]);
end

imout(find(imout<0))=0; imout(find(imout>255))=255;

