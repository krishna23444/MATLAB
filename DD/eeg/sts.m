function [X varargout]=sts(Y,H,G,KV,KG,lambda,varargin)
%
% X=sts(Y,H,G,KV,KG,lambda,options)
%
% Version for SpaRSA
%
% Solves norm(Y-H*X*G','fro')^2 + lambda*STS_PENALTY(X)
% where STS_PENALTY(X) is the sum over i,j of
% norm(X(sum(KV(1:i-1))+1:sum(KV(1:i)),sum(KG(1:i-1))+1:sum(KG(1:i))),'fro')

facIncrease=1.5;
facDecrease=0.33;

if nargin>6
  options=varargin{1};
else
  %options=struct([]);
  options.createdby='sts.m';
end

% --------- Set up default options -----------
% Step constant -- default largest singular value in forward prob.
if isfield(options,'step')
  p=options.step;
else
  l1=eigs(H*H',1);
  l2=eig(G'*G); l2=max(l2);
  p=1/(l1*l2);
  % Save EM step in options.step, start with 2*p below.
  %options=setfield(options,'step',p);
  options.step=p;
end
pMin=p;
% Penalty -- block l_1/l_2 (only?) by default
if isfield(options,'penalty')
  pen=options.penalty;
else
  pen=2; % Default now l2, was pen=1 ==> inf norm
  %options=setfield(options,'penalty',pen);
  options.penalty=pen;
end
% Initialize -- zeros if none provided
if isfield(options,'X')
  % Calc. inital penalty
  [X,cost_penalty,nblocks]=supershrink(options.X,sparse(sum(KV),sum(KG)),0,lambda,KV,KG,options);
  X=options.X;
else
  X=zeros(sum(KV),sum(KG));
  %options=setfield(options,'X',X);
  options.X=X;
  cost_penalty(1)=0; nblocks(1)=0;
end
% Maximum iterations allowed
if isfield(options,'maxits')
  max_its=options.maxits;
else
  max_its=5000; % Default good for hot start approach
  %options=setfield(options,'maxits',max_its);
  options.maxits=max_its;
end

% Stopping criterion -- could put an option
change_tol=0*10*eps; % Removed this condition for now (3/4/08)
dif=change_tol+1;

its=1;
atmin=0;
fevals=0;
% h=waitbar(0,sprintf('EM Iterations (%d total)',max_its));

% initial evaluation of function and the gradient of the smooth part
% cost(its) Grad cost_error(its) cost_penalty(its) nblocks(its)
fevals=fevals+1;
R = Y-H*X*G'; % Find fastest way to calc.
cost_error(its) = norm(R,'fro')^2;
%Grad = 2*H'*(R*G);
cost(its)=cost_error(its)+cost_penalty(its);
%[cost(its) Grad]=cost_w(X,Y,H,G,KV,KG,lambda,options);
while (its<max_its && ~atmin && dif>change_tol)
  Grad = H'*(R*G);
  its=its+1;

  % loop until reduction is achieved, reducing p each time
  % start at 2*option.p = 2*pMin
  cost(its)=cost(its-1); p=2*p/facDecrease; %innerIts=0;
  while cost(its)>=cost(its-1) && p>=pMin && ~atmin
    p=facDecrease*p;
    
    [Xnew cost_penalty(its) nblocks(its) atmin]=supershrink(X,Grad,p,lambda,KV,KG,options);
    
    % Check
    R = Y-H*Xnew*G';
    fevals=fevals+1;
    cost_error(its)=norm(R,'fro')^2;
    cost(its)=cost_error(its)+cost_penalty(its); %, p
  end
%   cost(its)
%   [cst GN] =cost_w(Xnew,Y,H,G,KV,KG,lambda,options); cst
  if cost(its)<cost(its-1) %p>pMin
    dif=norm(Xnew(:)-X(:));
    X=Xnew; %Grad=GradNew;
    p=facIncrease*p;
  elseif atmin
    cost(its)=cost(its-1);
    %X=Xnew;
%     cost_error(its)=cost_error(its-1);
%     cost_penalty(its)=cost_penalty(its-1);
%     atmin=1;
%     X=Xnew;
  else
      if isblockl2min(X,H,G,Y,KV,KG,lambda);
          fprintf('No more descent, satisfies subgradient condition.\n')
          cost(its)=cost(its-1);
      else
          fprintf('cannot get descent even with p below pMin. Terminate.\n'); %cost(its-1:its)
          its=its-1;
      end
      break;
  end
  
  % print out function value occasionally
  if mod(its,100)==0 || its==2
    fprintf(' it %6d  evals=%6d: obj=%12.4e, blocks=%4d p=%6.2e dif=%10.2e\n', ...
	its, fevals, cost(its), nblocks(its), p, dif);
  end

%   waitbar(its/max_its,h);
  
  % Testing purposes -- size of support
  %     [P d]=find(X); clear d
  %     sprt(its)=length(unique(P));
  %     
  %     cost(its)=stscost(X,Y,H,G,KV,KG,lambda);
end
%its %, figure, plot(sprt)
% close (h)
%[c err pen]=cost2(X,Y,H,speye(size(H,2)),Kp,lambda); c=err/(2*sigma2)+pen;
%fprintf('Final cost is: %0.5g, (err: %0.5g, pen: %0.5g)\n',c,err,pen)

options.its=its; %figure; plot(cost)

if nargout>1
  %varargout{1}=its; % old version
  % SpaRSA version
  
  varargout{1}=options;
end
fprintf('Final cost=%15.10e, its=%6d, lambda=%5.4e, nb=%4d\n', cost(its),its,lambda,nblocks(its));
