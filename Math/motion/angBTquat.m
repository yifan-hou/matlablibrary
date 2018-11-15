% find minimal angle (0~pi) between two quaternions.
% input:
% 	q1, q2: 4x1 unit quaternions.
function ang = angBTquat(q1,q2)
q1 = q1/norm(q1); 
q2 = q2/norm(q2);
ang = acos(2*(q1'*q2)^2-1);

end