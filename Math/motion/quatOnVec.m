% rotate a vector by quaternion
% input:
% 	v: 3xN
% 	q: 4x1
% output:
%	vr: 3xN
function vr = quatOnVec(v,q)
	if size(v,2) > 1
		% use rotation matrix
		m = quat2m(q);
		vr = m*v;
		return;
	end
	v  = [0; v];
	vr = quatMTimes(quatMTimes(q, v), quatInv(q));
	vr = vr(2:4);
end