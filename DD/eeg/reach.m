function v=reach(D,s)
%
% v=reach(D,s);
%
% D -- matrix of one neighbor distances, should use inf if not connected
% s -- label of starting node
% v -- vector of shortest distances from s to all other nodes
%
% Uses basic reaching (see Dynamic Programming: Models and Applications by
% Denardo)
%
% Updated 9/1/05 to handle sparse arguements.  Output is a full vector.
% 3/6/08 removed waitbar.

v=D(s,:);
if issparse(v)
    v=full(v);
    i=setdiff(find(~v),s);
    v(i)=inf;
end
%v
T=setdiff([1:size(D,2)],s);
%h=waitbar(0,'Please wait...');
while ~isempty(T)
    [y i]=min(v(T)); % !!!
    compv=D(T(i),T); % Replacement to deal with sparsity
    if issparse(compv)
        compv=full(compv);
        ind=setdiff(find(~compv),i);
        compv(ind)=inf;
    end
    %compv;
    v(T)=min([v(T);v(T(i))+compv]);
    T=setdiff(T,T(i));
    %waitbar(1-length(T)/length(v),h); %v
end
%close(h);