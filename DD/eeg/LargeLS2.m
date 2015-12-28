function Xhat=LargeLS2(Y,H,G,KH,KG,cmap)
%
% Xhat=LargeLS2(Y,H,G,KH,KG,cmap);
%
% For now, assumes KH, KG are const*ones(numblocks,1).  In other words,
% same number of bases per block.

KHc=cumsum(KH);
KGc=cumsum(KG);

[x y]=size(cmap);
if x==size(H,2) && y==size(G,2)
    % Probably better method
    a=[]; b=[];
    for c=1:length(KH)
        for d=1:length(KG)
            x=cmap(KHc(c)-KH(c)+1:KHc(c),KGc(d)-KG(d)+1:KGc(d));
            x=full(x(:));
            if ~isempty(find(x,1))
                a=[a;c];
                b=[b;d];
            end
        end
    end
elseif x==length(KH) && y==length(KG)
    [a b]=find(cmap);
end

%s=KH(1)*KG(1);
t=length(a);
if t==0
    Xhat=zeros(size(H,2),size(G,2));
    return
end
A=sparse(sum(KH(a).*KG(b)),sum(KH(a).*KG(b)));
Aty=zeros(sum(KH(a).*KG(b)),1);

h=waitbar(0,'Building Matrix');
curc=1;
for c=1:t
%     Hi=H(:,sum(KH(1:a(c)))-KH(a(c))+1:sum(KH(1:a(c))));
%     Gi=G(:,sum(KG(1:b(c)))-KG(b(c))+1:sum(KG(1:b(c))));
    Hi=H(:,KHc(a(c))-KH(a(c))+1:KHc(a(c)));
    Gi=G(:,KGc(b(c))-KG(b(c))+1:KGc(b(c)));
    curd=1;
    for d=1:t
%         Hj=H(:,sum(KH(1:a(d)))-KH(a(d))+1:sum(KH(1:a(d))));
%         Gj=G(:,sum(KG(1:b(d)))-KG(b(d))+1:sum(KG(1:b(d))));
        Hj=H(:,KHc(a(d))-KH(a(d))+1:KHc(a(d)));
        Gj=G(:,KGc(b(d))-KG(b(d))+1:KGc(b(d)));
        %A(s*c-s+1:s*c,s*d-s+1:s*d)=kron(Gi'*Gj,Hi'*Hj);
        %size(kron(Gi'*Gj,Hi'*Hj))
        A(curc:curc+KH(a(c))*KG(b(c))-1,curd:curd+KH(a(d))*KG(b(d))-1)=kron(Gi'*Gj,Hi'*Hj);
        %curd=curd+KG(b(d));
        curd=curd+KH(a(d))*KG(b(d));
    end
    %Aty(c*s-s+1:c*s)=reshape(Hi'*Y*Gi,s,1);  %kron(Gi,Hi)'*y;
    Aty(curc:curc+KH(a(c))*KG(b(c))-1)=reshape(Hi'*Y*Gi,KH(a(c))*KG(b(c)),1);
    %curc=curc+KH(a(c));
    curc=curc+KH(a(c))*KG(b(c));
    waitbar(c/t,h);
end
close(h)
%curc, curd
gamma=eigs(A,1);
%X=inv(A+speye(s*t)*gamma/10000)*Aty;
X=(A+speye(length(A))*gamma/100)\Aty; % was 10000

%X=lsqr(A,Aty,[],100);

Xhat=zeros(size(H,2),size(G,2));
curc=1;
for c=1:t
    i1=sum(KH(1:a(c)))-KH(a(c))+1:sum(KH(1:a(c)));
    i2=sum(KG(1:b(c)))-KG(b(c))+1:sum(KG(1:b(c)));
    %Xhat(i1,i2)=reshape(X(c*s-s+1:c*s),KH(a(c)),KG(b(c)));
    Xhat(i1,i2)=reshape(X(curc:curc+KH(a(c))*KG(b(c))-1),KH(a(c)),KG(b(c)));
    curc=curc+KH(a(c))*KG(b(c));
end
