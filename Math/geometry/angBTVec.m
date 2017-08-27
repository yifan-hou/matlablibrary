% find the (signed) angle from vector x to vector b.
% input:
% 	x, b: Dx1 vector.
% 	z: 3x1, if specified, it is the normal of the plane. D has to be 3.
% 		the result is in [-pi, pi]
% 		if unspecified, the angle calculated is in [0 pi]
% 	nonnegative: if specified, result is in [0 2*pi]
function ang = angBTVec(x,b,z,nonnegative)

if nargin <= 2
	x = x/norm(x);
	b = b/norm(b);
	ang = acos(dot(x, b));
else
	z = z/norm(z);
	ang = atan2(cross(x,b)'*z, x'*b);
	if nargin == 4
		if ang < 0
			ang = 2*pi + ang;
		end
	end
end

end