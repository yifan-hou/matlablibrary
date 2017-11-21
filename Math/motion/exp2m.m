% n: 3x1 vector
function R = exp2m(n)

theta = normByCol(n);
n = bsxfun(@rdivide, n, theta);

cw = [0 -n(3) n(2) ; n(3) 0 -n(1) ; -n(2) n(1) 0 ];

R = eye(3) + cw*sin(theta) + cw*cw*(1-cos(theta));