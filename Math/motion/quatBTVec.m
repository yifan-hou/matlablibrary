% Calculate the quaternion that rotates v1 to v2
% q v1 q* = v2
% input:
% 	v1,v2: 3 x 1 
% output
% 	q: 4 x 1
function q = quatBTVec(v1, v2)
q = zeros(4,1);
q(1)   = sqrt((v1'*v1) * (v2'*v2)) + v1'*v2;
if abs(q(1)) < 1e-9
    q = [-1 0 0 0]';
    return;
end

q(2:4) = cross(v1, v2);
q = q/norm(q);
end