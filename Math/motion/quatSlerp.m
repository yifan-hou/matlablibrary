% Quaternion Sphere Linear Interpolation
% Inputs
% 	q0: 4x1 unit quaternion.
% 	q1: 4x1 unit quaternion.
% 	t: 1xN, [0, 1]
% Outputs
% 	qi: 4xN unit quaternions
function qi = quatSlerp(q0, q1, t)
	if q0'*q1 < 0
		% ensure the shortest path is chosen
		q1 = - q1;
	end
	temp = quatPow(quatMTimes(quatInv(q0),q1), t);
	qi = quatMTimes(q0, temp);
end