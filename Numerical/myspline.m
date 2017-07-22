function [y,yd,ydd] = myspline(X,Y,xx)
if size(Y,1) ~= 1
    Y = Y';
end
if size(X,1) ~= 1
    X = X';
end

N = length(X);
% % figure out YD at knot points
% Check that data are acceptable and, if not, try to adjust them appropriately
n = length(X);

% Generate the cubic spline interpolant in ppform
dd = ones(1,1); dx = diff(X); divdif = diff(Y,[],2)./dx(dd,:);

% set up the sparse, tridiagonal, linear system b = ?*c for the slopes
b=zeros(1,n);
b(:,2:n-1)=3*(dx(dd,2:n-1).*divdif(:,1:n-2)+dx(dd,1:n-2).*divdif(:,2:n-1));

x31=X(3)-X(1);xn=X(n)-X(n-2);
b(:,1)=((dx(1)+2*x31)*dx(2)*divdif(:,1)+dx(1)^2*divdif(:,2))/x31;
b(:,n)=...
    (dx(n-1)^2*divdif(:,n-2)+(2*xn+dx(n-1))*dx(n-2)*divdif(:,n-1))/xn;

dxt = dx(:);
c = spdiags([ [x31;dxt(1:n-2);0] ...
    [dxt(2);2*(dxt(2:n-1)+dxt(1:n-2));dxt(n-2)] ...
    [0;dxt(2:n-1);xn] ],[-1 0 1],n,n);

% sparse linear equation solution for the slopes
mmdflag = spparms('autommd');
spparms('autommd',0);
YD=b/c;
spparms('autommd',mmdflag);




%  obtain the row vector xs equivalent to XX
lx = numel(xx); xs = reshape(xx,1,lx);

% for each evaluation site, compute its breakpoint interval
[~,index] = histc(xs,[-inf,X(2:end-1),inf]);

y   = zeros(N,1);
yd  = y;
ydd = y;
for i = 1:N-1
    idx = (index == i);
    [tp, tpd, tpdd] = myspline22(xx(idx), X(i),X(i+1),Y(i),Y(i+1),YD(i),YD(i+1));
    y(idx)          = tp;
    yd(idx)         = tpd;
    ydd(idx)        = tpdd;
end

end