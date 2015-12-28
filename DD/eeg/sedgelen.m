function [D,varargout]=sedgelen(faces,verts,varargin)
%
% D=sedgelen(faces,verts)
%          <or>
% [D pid_out]=sedgelen(faces,verts,pid_in)
%
% Inputs:  faces      M x 3 vector of surface faces with entries in [1:N]
%          verts      N x 3 vector of node locations, Cartesian coordinates
%          pid_in     L x 1 optional, specifies subset of nodes (verts)
%
% Outputs: D          Sparse matrix of edge lengths.
%                     Caution: 0 means a length of zero or not connected.
%          pid_out    optional, specifies subset of nodes actually used.
%
% Written by: Andrew Bolstad, 4/5/2005.

% Use whole surface or define patch from user input
pid=[1:size(verts,1)]';
patch_flag=0;
if nargin>2
    pid=varargin{1};
    patch_flag=1;
end

% Keep faces with nodes in pid
if patch_flag
    Fg=faces(find(sum(ismember(faces,pid),2)==3),:);
else
    Fg=faces;
end

% Eliminate 'unconnected' vertices; i.e., those con. via only 1 edge.
pid=pid(find(ismember(pid,Fg)));
if nargout>=2
    varargout{1}=pid;
end

% Find 1 neighbor distances
D=sparse(length(pid),length(pid));
h=waitbar(0,'sedgelen.m: Calculating Edge Lengths...');
M=size(Fg,1);
for c=1:M
    waitbar(c/M,h)
    
    v1=find(pid==Fg(c,1));
    v2=find(pid==Fg(c,2));
    v3=find(pid==Fg(c,3));
    
    D(v1,v2)=sqrt(sum((verts(pid(v1),:)-verts(pid(v2),:)).^2));
    D(v2,v1)=sqrt(sum((verts(pid(v1),:)-verts(pid(v2),:)).^2));
    
    D(v3,v2)=sqrt(sum((verts(pid(v2),:)-verts(pid(v3),:)).^2));
    D(v2,v3)=sqrt(sum((verts(pid(v2),:)-verts(pid(v3),:)).^2));
    
    D(v1,v3)=sqrt(sum((verts(pid(v1),:)-verts(pid(v3),:)).^2));
    D(v3,v1)=sqrt(sum((verts(pid(v1),:)-verts(pid(v3),:)).^2));
end
close(h)