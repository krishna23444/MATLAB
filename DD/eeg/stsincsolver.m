function [BlockAnswer,varargout]=stsincsolver(Y,H,G,KH,KG,varargin)
%
% [BlockAnswer,options]=stsincsolver(Y,H,G,KH,KG,varargin)
inc=0.01;
XT=zeros(size(H,2),size(G,2));
startL=1;
endL=0.1;
l1=eigs(H*H',1);
l2=eig(G'*G); l2=max(l2);
p=1/(l1*l2);

if nargin>5
    options=varargin{1};
else
    %options=struct([]);
    options.createdby='stsincsolver.m';
end
if ~isfield(options,'step')
    options.step=p;
end
if ~isfield(options,'X')
    options.X=XT;
end
% if isfield(options,'lcurve')
%     lcflag=1;
%     options.lcurve=zeros(2,round((startL-endL)/inc)+1);
% end
if isfield(options,'startL')
    startL=options.startL;
end
if isfield(options,'endL')
    endL=options.endL;
end
np=round((startL-endL)/inc+1);
BlockAnswer=sparse(sum(KH),np*sum(KG));
options.its=zeros(round((startL-endL)/inc+1),1);

M=stsmaxlambda(H,G,Y,KH,KG,options);
clear l1 l2 p XT
h=waitbar(0,sprintf('stsincsolver.m Iterations (%d total)',np));
ind=1;
its=zeros(np,1);
for c=startL:-inc:endL
    
    %[X,options]=emstsSpaRSA(Y,H,G,KH,KG,c*M,options);
    [X,options]=sts(Y,H,G,KH,KG,c*M,options);
    options.X=X;
    its(ind)=options.its;
    
    %BlockIndex(:,(ind-1)*length(KG)+1:ind*length(KG))=findblocks(options.X,KH,KG);
    % This might cause memory issues.
    BlockAnswer(:,(ind-1)*sum(KG)+1:ind*sum(KG))=options.X;
        
%     if lcflag
%         % Use lambda=1 so pen is not multiplied by lambda
%         [cst mis pen]=stscost(options.X,Y,H,G,KH,KG,1);
%         options.lcurve(:,ind)=[mis;pen];
%     end
    
    ind=ind+1;
    waitbar(ind/np,h);
end
close(h)
options.its=its;
%save Tempres %plot(its)
if max(options.its)>=options.maxits
    t=find(options.its>=options.maxits,1,'last');
    sprintf('Tolerance not met for some cases.  The last of these was %d.\n',t)
end

if nargout>1
    varargout{1}=options;
end