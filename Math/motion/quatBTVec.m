% Calculate the quaternion that rotates a to b
% q a q* = b
% input:
% 	a,b: 3 x 1 
% output
% 	q: 4 x 1
% Reference
% 	https://stackoverflow.com/questions/1171849/finding-quaternion-representing-the-rotation-from-one-vector-to-another
% 	https://github.com/toji/gl-matrix/blob/f0583ef53e94bc7e78b78c8a24f09ed5e2f7a20c/src/gl-matrix/quat.js#L54
function q = quatBTVec(a, b)
a = a/norm(a);
b = b/norm(b);

xUnitVec3 = [1 0 0]';
yUnitVec3 = [0 1 0]';

c = a'*b;

if c < -0.999999
	tmpvec3 = cross(xUnitVec3, a);
	if norm(tmpvec3) < 0.000001
		tmpvec3 = cross(yUnitVec3, a);
	end
	tmpvec3 = tmpvec3/norm(tmpvec3);
	q = aa2quat(pi, tmpvec3);
elseif c > 0.999999
	q = [1 0 0 0]';
else
	q = zeros(4,1);
	q(1) = 1 + c;
	q(2:4) = cross(a,b);
	q = q/norm(q);
end

end