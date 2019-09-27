% rotate a vector by quaternion
% input:
% 	v: 3xN
% 	q: 4x1
% output:
%	vr: 3xN
function vr = quatOnVec(v,q)
	if size(v,2) > 1
		% use rotation matrix
		m = quat2SO3(q);
		vr = m*v;
		return;
	end
	v  = [0; v];
	temp1 = quatMTimes(q, v);
	temp2 = quatInv(q);
	vr = quatMTimes(temp1, temp2);
	vr = vr(2:4);
end