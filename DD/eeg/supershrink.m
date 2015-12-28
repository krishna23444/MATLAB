function [X,varargout]=supershrink(Xold,Grad,step,lambda,Kp,Kg,varargin)

% [X (pen) (nblocks) (ismin) (subcon)]=supershrink(Xold,Grad,step,lambda,Kp,Kg,varargin)
%
%

useNbpen=1;
tol1=1e-9;
tol2=1e-3; % larger tolerance for nonzero blocks
if nargin>6
    if isfield(varargin{1},'useNbpen')
        useNbpen=varargin{1}.useNbpen;
    end
    if isfield(varargin{1},'ststol1')
        tol1=varargin{1}.ststol1;
    end
    if isfield(varargin{1},'ststol2')
        tol2=varargin{1}.ststol2;
    end
end

% Remains 1 if zero blocks satisfy subgradient condition
zchk=1;
% Remains 1 if nonzero blocks satisfy subgradient condition
nzchk=1;

nblocks=0;

% Note: Grad is H'*(Y-H*X*G')*G (no lambda)
delX=step*Grad;
Z=Xold+delX;

X=zeros(size(Z));
pen=0;
curU=1;
for cu=1:length(Kp)
    curG=1;
    for cg=1:length(Kg)
        zs=Z(curU:curU+Kp(cu)-1,curG:curG+Kg(cg)-1); % For shrinking
        x=Xold(curU:curU+Kp(cu)-1,curG:curG+Kg(cg)-1); % For checking
        x=full(x(:));
        bt=2*Grad(curU:curU+Kp(cu)-1,curG:curG+Kg(cg)-1)/lambda;
        bt=full(bt(:));
        
        nz=norm(zs,'fro');
        
        wt=1;
        if useNbpen
            wt=sqrt(Kp(cu)*Kg(cg));
        end
        
        % Shrink / penalty calc. part
        if 2*nz > step*lambda*wt
            X(curU:curU+Kp(cu)-1,curG:curG+Kg(cg)-1)=...
                (1-step*lambda*wt/(2*nz))*zs;
            pen=pen+wt*(nz-step*lambda*wt/2);
        end
        
        % Check Xold part -- seems too sensitive
        if isempty(find(x,1)) %x'*x==0 
            tst=norm(bt,'fro')/wt-1;
            zchk=zchk*(tst<=tol1);
        else
            nzchk=nzchk*(norm(bt/wt-x/norm(x),'fro')<=tol2); %0.001
            nblocks=nblocks+1; %norm(x)
        end
        
        curG=curG+Kg(cg);
    end
    curU=curU+Kp(cu);
end

ismin=zchk*nzchk;
pen=lambda*pen;

if nargout>1
    varargout{1}=pen;
end
if nargout>2
    varargout{2}=nblocks;
end
if nargout>3
    varargout{3}=ismin;
end
if nargout>4
    varargout{4}=[zchk nzchk];
end