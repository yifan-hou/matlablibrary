% X: N by nx, data
% Y: N by ny, data
% x: n by nx, query points
% y: n by ny, ground truth of queries
% k: scalar, distance scale. 
% kw: n by 1, weight between different entries when calculating distance
% nn: number of nearest neighbors
% return: prediction error
function [k,kw,nn] = LWR_PARA_TUNING_SINGLE(X,Y,x,y,pinit,prange)

[N1, ~] = size(X);
[N2, ~] = size(Y);
[N3, ~] = size(x);
[N4, ~] = size(y);

if (N1~=N2)||(N3~=N4)
	error('Wrong dimension.');
end

nn = 20;

LB = [prange.k(2); prange.kw(:,2)];
UB = [prange.k(1); prange.kw(:,1)];
options = optimoptions('fmincon','Display','final-detailed',...
			'GradObj','off', 'MaxFunEvals',100);
               % 'Algorithm','active-set',...
p0 = [pinit.k;pinit.kw];
p = fmincon(@(p)LWR_VALIDATION_SINGLE(X,Y,x,y,p(1),p(2:end),nn),p0,[],[],[],[],LB,UB,[],options);

k = p(1)
kw = p(2:end)


end

