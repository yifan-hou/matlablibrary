% exponential coordinate to rotation matrix
% (Rodriguez's formula)
%
% n: 3x1 vector
function R = so32SO3(n)
theta  = norm(n);
if isnumeric(n)
	if theta > 1e-10
	    n  = n/theta;
	    cw = [0 -n(3) n(2) ; n(3) 0 -n(1) ; -n(2) n(1) 0 ];
	    R  = eye(3) + cw*sin(theta) + cw*cw*(1-cos(theta));
	else
	    R = eye(3);
	end
else
	n  = n/theta;
	cw = [0 -n(3) n(2) ; n(3) 0 -n(1) ; -n(2) n(1) 0 ];
	R = eye(3) + cw*sin(theta) + cw*cw*(1-cos(theta));
end