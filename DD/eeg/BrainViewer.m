function h=BrainViewer(data,faces,verts,varargin)
%
% h=BrainViewer(data,faces,verts,[norms])

if (length(data)~=size(verts,1) & nargin<4)
    error('Data dimension mismatch.  Please provide normals.')
end

nflag=0;
if nargin>3
    norms=varargin{1};
    nflag=1;
    if length(data)~=3*size(norms,1)
        if length(data)~=size(verts,1)
            error('Data dimension mismatch.')
        else
            warning('Normals are unnecassary and will be ignored.')
            nflag=0;
        end
    end
end

if nflag
    x=zeros(length(data)/3,1);
    for c=1:length(x)
        x(c)=norms(c,:)*data(3*c-2:3*c);
    end
    x=abs(x);
else
    x=data;
end

Cmap = jet(100);

h = patch('faces',faces,'vertices',verts,'FaceVertexCData',x);
colormap(Cmap);colorbar
camlight;
set(h,'FaceLighting','phong');
set(h,'FaceColor','interp');
set(h,'EdgeColor','none');
material dull;
daspect([1 1 1]);axis tight;
view(0,0);
lightangle(45,45);
camup([0 -1 1]);
box off;
axis off;