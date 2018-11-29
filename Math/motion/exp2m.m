% exponential coordinate to rotation matrix
% (Rodriguez's formula)
%
% n: 3xk vector
function R = exp2m(n)

theta  = normByCol(n);
theta_ = ones(3,1)*theta;
n      = n./theta_;

cw = [0 -n(3) n(2) ; n(3) 0 -n(1) ; -n(2) n(1) 0 ];

R = eye(3) + cw*sin(theta) + cw*cw*(1-cos(theta));