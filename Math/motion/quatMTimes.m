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
        if isnumeric(q1)
            cr_v = zeros(3,N);
        else
            cr_v = sym(zeros(3, N));
        end
        for i = 1:N
            cr_v(:,i) = cross_(v1, v2(:, i));
        end
        qp = [s1*s2-v1'*v2; s1*v2+v1*s2 + cr_v];
    else
        N    = size(q1, 2);
        if isnumeric(q1)
            cr_v = zeros(3,N);
        else
            cr_v = sym(zeros(3, N));
        end

        for i = 1:N
            cr_v(:,i) = cross_(v1(:,i), v2);
        end
        qp = [s1*s2 - v2'*v1; v2*s1 + s2*v1 + cr_v];
    end
end

% to be ok with symbolic derivations
function c = cross_(a, b)
    c =[a(2)*b(3) - a(3)*b(2);
        a(3)*b(1) - a(1)*b(3);
        a(1)*b(2) - a(2)*b(1)];
end