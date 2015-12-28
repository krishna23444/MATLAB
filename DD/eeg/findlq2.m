function pt=findlq2(t,varargin)
%
%

t=t(:);
lt=length(t);

if lt<3
    pt=2;
    disp('Short Input.')
    return
end

if nargin>1
    lt2=100;
    tlt=varargin{1};
else
    tlt=t(lt);
    lt2=lt;
end

thr=inf;
pt=1;
qreg=zeros(2,1);
bestcurve=zeros(1,lt2+1);
error=zeros(lt-2,1);
for c=2:lt-1
    curve1=linspace(0,t(c),c)';
    qreg=[(tlt-t(c))/(lt2-c+1)^2;t(c)]; %size(((c:lt2)-c).^2), lt2-c+1
    curve2=[((c:lt2)'-c).^2 ones(lt2-c+1,1)]*qreg; %size(curve1), size(curve2(1:lt-c+1))
    error(c-1)=norm(curve1-t(1:c))^2+norm(curve2(1:lt-c+1)-t(c:lt))^2;
    
    if error(c-1)<thr
        pt=c;
        thr=error(c-1);
        bestcurve=[curve1(:);curve2(:)];
    end
end

%figure; plot(t), hold on, plot(1:lt2+1,bestcurve,'r')
%figure; plot(error)