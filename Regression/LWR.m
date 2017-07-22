% X: N by n, data
% Y: N by m, data
% x0: n by 1, query point
% return: 
	% Y = Beta*[X; 1]
function [Beta] = LWR(X,Y,x0,k,kw)
[N, n] = size(X);
[~, m] = size(Y);

% calculate distance
kw = kw/norm(kw);
dv = zeros(N,n);
for i=1:n
	dv(:,i) = (X(:,i) - x0(i))*kw(i);
end
d  = normByRow(dv);

% filter points. 5k: weight = 0.08
% idf = (d < 15*k);
% idf = ones(1, length(d));
% N = sum(idf);

% calculate weight
w = exp(-d / 2 / k);
w = w/norm(w);

% weighed data
Xw = [X ones(N,1)].*(w*ones(1,n+1));
Yw = Y.*(w*ones(1,m));

% Ridge regression (X^TX + lambda)beta = X^Ty
lambda = eye(n + 1) * 1e-6;
Beta = linsolve( (Xw'*Xw + lambda), Xw'*Yw)';

end