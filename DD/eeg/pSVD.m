function [Uc Vc Patch_evals]=pSVD(Hr,W,numb,varargin)
%
% [Uc Vc Patch_evals]=pSVD(Hr,W,numb)
%
% Revised 3/4/08
% Hr is the lead field matrix (M x D or M x 3d)
% Each column of a W is a patch -- can be 0/1 or list of dipoles
% numb is either the number of bases per patch or the fraction of energy
% preserved.

if nargin>3
    knownflag=varargin{1};
else
    knownflag=0;
end

pidflag=0;
if max(W(:))>1
    pidflag=1;
end

Uc=[];
Vc=[];
Patch_evals=sparse(size(W,1),size(W,2)); % Fix
mxrnk=0;
for c=1:size(W,2)
    if pidflag
        H_id=setdiff(W(:,c),0);
    else
        H_id=find(W(:,c));
    end
    H=[];
    if knownflag
        for d=1:length(H_id)
            H=[H, Hr(:,H_id(d))];
        end
    else
        for d=1:length(H_id)
            H=[H, Hr(:,3*H_id(d)-2:3*H_id(d))];
        end
    end
    if numb>=1
        [U S V]=svds(H,numb);
        rnk=numb;
    else
%         U=[]; S=[]; V=[]; rnk=0;
%         maxr=min(size(H));
%         lastsv=norm(H,'fro');
%         tot_p=lastsv^2; pw=0;
%         while pw/tot_p<numb
%             % Only checks 5 or 6 at a time
%             [Ut St Vt]=svds(H,min(6,maxr),lastsv);
%             lastsv=St(end,end);
%             maxr=maxr-5;
%             t=cumsum(diag(St).^2);
%             r=find(t<(numb*tot_p-pw),1,'last')+1;
%             if isempty(r)
%                 r=1;
%             end
%             if r==min(7,maxr+1)
%                 % Take one away to avoid double count
%                 r=r-1;
%             end
%             pw=pw+t(r);
%             U=[U,Ut(:,1:r)];
%             S=diag([diag(S);diag(St(1:r,1:r))]); %size(S)
%             V=[V,Vt(:,1:r)];
%             rnk=rnk+r;
%         end
        [U,Ur,Uorth,Sr,Vr,rnk] = rnkreduce(H,numb);
        U=Ur;
        S=Sr;
        V=Vr;
        clear Ur Uorth Sr Vr
    end
    Uc=[Uc, U];
    Vc=[[Vc;zeros(max(size(V,1)-size(Vc,1),0),size(Vc,2))],...
        [V;zeros(max(size(Vc,1)-size(V,1),0),size(V,2))]];
    Patch_evals(1:rnk,c)=diag(S);
    if rnk>mxrnk
        mxrnk=rnk;
    end
end
Patch_evals=Patch_evals(1:mxrnk,:);
