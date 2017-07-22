% estimation range of interval
% X: N by n, data
% Y: N by m, data
% x0: 1 by n, query point
% k: scalar, distance scale. 
% kw: n by 1, weight between different entries when calculating distance
% return: INTERVAL
function [INTERVAL] = LWR_INTERVAL(X,Y,x0,k,kw)
[N, n] = size(X);
[N0, m] = size(Y);

if N~=N0
	error('LWR: input dimension error.');
end

% calculate distance
dv = zeros(N,n);
for i=1:n
	dv(:,i) = (X(:,i) - x0(i))*kw(i);
end
d  = normByRow(dv);

idx = abs(d)<(2*k);
Ni  = sum(idx);

% calculate weight
W = exp(-d(idx)/2/k^2);
w = W/norm(W);

% weighed data
Xw = [X(idx,:) ones(Ni,1)].*(w*ones(1,n+1));
Yw = Y(idx,:).*(w*ones(1,m));

% Ridge regression (X^TX + lambda)beta = X^Ty
lambda = eye(n + 1) * 1e-6;
Beta = linsolve( (Xw'*Xw + lambda), Xw'*Yw);

N_ = sum(W.^2);
p_ = (n+1)*N_/N;
err = ( [X ones(N,1)]*Beta - Y );
S = sqrt( err'*(W'*W)*err/(N_ - p_) );

INTERVAL = S*sqrt(1+x0*(X'*(W'*W)*X)^-1*x0');

end

