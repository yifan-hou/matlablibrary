% find the distance between two quaternions.
% input:
% 	q1, q2: 4x1 unit quaternions.
function ang = angBTquat(q1,q2)
q1 = q1/norm(q1); 
q2 = q2/norm(q2);

q_ = quatMTimes(quatInv(q1), q2);

ang = 2*acos(q_(1)); % acos: [0, pi]

if ang > pi
	ang = ang - 2*pi;
end

ang = abs(ang);

end