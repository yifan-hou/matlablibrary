% calculate the rotation matrix between two vector,
% 	m*a = b
% inputs
% 	a: 3x1
%   b: 3x1
% Based on
% 	https://math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d
function m = SO3BTVec(a,b)
a = a/norm(a);
b = b/norm(b);
crossAB = cross(a,b);
if norm(crossAB) < 1e-8
	% singularity, a and b are parallel
	if a'*b > 0
		m = eye(3);
	else
	 	m = -eye(3);
 	end
 	return;
end 

ssc = @(v) [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];
m   = eye(3) + ssc(crossAB) + ssc(crossAB)^2*(1-dot(a,b))/(norm(crossAB)^2);

end