% quaternion multiplication
% rotate by p then q, is equal to rotate by qp.
% input:
% 	q1: 4x1
% 	q2: 4x1
% output:
%	qp: 4x1
function qp = quatMTimes(q1, q2)
	s1 = q1(1);
	v1 = q1(2:4);

	s2 = q2(1);
	v2 = q2(2:4);

	qp = [s1*s2-v1'*v2; s1*v2+s2*v1+cross(v1,v2)];
end