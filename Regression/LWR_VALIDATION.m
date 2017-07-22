% X: N by nx, data
% Y: N by ny, data
% x: n by nx, query points
% y: n by ny, ground truth of queries
% k: scalar, distance scale. 
% kw: n by 1, weight between different entries when calculating distance
% nn: number of nearest neighbors
% return: prediction error
function cost = LWR_VALIDATION(X,Y,x,y,k,kw)

[N, ~] = size(x);

yp = y;
for i=1:N
	Beta = LWR(X,Y,x(i,:),k,kw);
	yp(i,:) = Beta*[x(i,:)';1];
end

cost = norm(yp - y);

end

