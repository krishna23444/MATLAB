function [V Kp]=makeV(Vc,W,Patch_evals,varargin)
%
% [V Kp]=makeV(Vc,W,Patch_evals)
% [V Kp]=makeV(Vc,W,Patch_rank,1)
% Modified 3/4/08 to accept patches defined by P, e.g.: makeV(Vc,P,Patch_evals)

prflag=0;
if nargin>3
    if varargin{1}==1
        prflag=1;
    end
end

if max(W(:))>1
    W=P2W(W);
end

Nb=size(Vc,2);
if prflag % patch rank in this case
    Np=length(Patch_evals);
    Kp=Patch_evals(:);
else
    Np=size(Patch_evals,2);
    Kp=zeros(Np,1);
    for count=1:Np
        Kp(count)=max(find(Patch_evals(:,count)));
    end
end

% Make V matrix
if sum(W(:,1))*3==max(find(Vc(:,1))) %sum(abs(Vc(sum(W(:,1))+[1:3],1)))
    % Unknown Moment
    vec=[1;1;1];
else
    % Known Moment
    vec=1;
end
V=sparse(length(vec)*size(W,1),Nb);
curi=1;
for count=1:Np
    for c2=1:Kp(count)
        V(find(kron(W(:,count),vec)),curi+c2-1)=...
            Vc(1:length(vec)*full(sum(W(:,count))),curi+c2-1);
    end
    curi=curi+Kp(count);
end
