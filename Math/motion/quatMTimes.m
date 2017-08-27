% quaternion multiplication
% rotate by p then q, is equal to rotate by qp.
% input:
% 	q1: 4x1  	q2: 4xN
% 	or
% 	q1: 4xN  	q2: 4x1
% output:
%	qp: 4xN
function qp = quatMTimes(q1, q2)
	s1 = q1(1, :);
	v1 = q1(2:4, :);

	s2 = q2(1, :);
	v2 = q2(2:4, :);

    N = size(q2, 2);
    if N > 1
	    cr_v = zeros(3,N);
	    for i = 1:N
	        cr_v(:,i) = cross(v1, v2(:,i));
	    end
		qp = [s1*s2-v1'*v2; s1*v2+v1*s2 + cr_v];
	else
		N    = size(q1, 2);
		cr_v = zeros(3, N);
		for i = 1:N
			cr_v(:,i) = cross(v1(:,i), v2);
		end
		qp = [s1*s2 - v2'*v1; v2*s1 + s2*v1 + cr_v];
	end
end