function [f varargout]=isblockl2min(X,H,T,Y,Kp,Kg,lambda,varargin)
%
% f=isblockl2min(X,H,T,Y,Kp,Kg,lambda,(options))
%
% Checks if X minimizes norm(Y-H*X*T','fro')^2 + lambda*STS_PENALTY(X)
%
% Modified to use sqrt(#bases/patch) in the penalty, can be turned off with
% options.useNbpen=0.


HtH=H'*H;
HtY=H'*Y;
b=2*(HtY-HtH*X*T')*T/lambda;
Ks=[0;cumsum(Kp(:))];
Kt=[0;cumsum(Kg(:))];

tol1=1e-9;
tol2=1e-3; % larger tolerance for nonzero blocks
useNbpen=1;
if nargin>7
    if isfield(varargin{1},'ststol1')
        tol1=varargin{1}.ststol1;
    end
    if isfield(varargin{1},'ststol2')
        tol2=varargin{1}.ststol2;
    end
    if isfield(varargin{1},'useNbpen')
        useNbpen=varargin{1}.useNbpen;
    end
end

% Remains 1 if zero blocks satisfy subgradient condition
zchk=1;
% Remains 1 if nonzero blocks satisfy subgradient condition
nzchk=1;

% Added 9/2/08 to record maximum violations
maxz=0; maxnz=0;

%curp=1;
for cp=1:length(Kp)
    px=Ks(cp)+1:Ks(cp+1);
    %curg=1;
    for cg=1:length(Kg)
        gx=Kt(cg)+1:Kt(cg+1);
        
        %Old Way: x=X(curp:curp+Kp(cp)-1,curg:curg+Kg(cg)-1);
        x=X(px,gx);
        x=full(x(:));
        bt=b(px,gx);
        bt=full(bt(:));
        
        wt=1;
        if useNbpen
            wt=sqrt(Kp(cp)*Kg(cg));
        end
        
        % use fastest way to determine if a vector == 0
        % x'*x==0, sum(x~=0), etc.
        if x'*x==0 
            tst=norm(bt,2)/wt-1;
            zchk=zchk*(tst<=tol1);
            % added 9/2/08
            if tst>maxz
                maxz=tst;
            end
        else
            tst=norm(bt/wt-x/norm(x)); % modified 9/2/08
            nzchk=nzchk*(tst<=tol2); %0.001
            %norm(x)
            % added 9/2/08
            if tst>maxnz
                maxnz=tst;
            end
        end
        
        %curg=curg+Kg(cg);
    end
    %curp=curp+Kp(cp);
end

f=zchk*nzchk;
if nargout==2
    varargout{1}=[zchk nzchk];
elseif nargout>2
    varargout{1}=[zchk nzchk];
    varargout{2}=[maxz maxnz];
end
