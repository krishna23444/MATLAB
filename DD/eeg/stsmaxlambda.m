function M=stsmaxlambda(H,G,Y,KV,KG,varargin)
%
% M=stsmaxlambda(H,G,Y,KV,KG)
%
% Calculates the smallest lambda for which X=0 minimizes
% norm(H*X-Y,'fro')^2 + lambda*||X||_{sts}
%
% Modified 3/4/08 to use sqrt(#bases in block) in the penalty for each
% block.  Mod. 3/24/08 to make this optional.

nt=1;
useNbpen=1;
if nargin>5
    if isfield(varargin{1},'penalty')
        nt=varargin{1}.penalty;
    else
        nt=1;
    end
    if isfield(varargin{1},'useNbpen')
        useNbpen=varargin{1}.useNbpen;
    end
end
B=2*H'*Y*G;
M=0;
curi=1;
for c=1:length(KV)
    curi2=1;
    for d=1:length(KG)
        b=B(curi:curi+KV(c)-1,curi2:curi2+KG(d)-1);
        b=b(:);
%         if norm(b,1)>M
%             c,d
%         end
        wt=1;
        if useNbpen
            wt=sqrt(KV(c)*KG(d));
        end
        M=max(M,norm(b,nt)/wt);
        
        curi2=curi2+KG(d);
    end
    curi=curi+KV(c);
end
