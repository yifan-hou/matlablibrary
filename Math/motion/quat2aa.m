% quaternion to Axis-angle
% input:
% 	q: 4 x m
% output:
%	theta: 1 x m
% 	n: 3 x m
function [theta, n] = quat2aa(q)
	theta = 2*acos(q(1));
	qv = q(2:4,:);
	qvnorm = normByCol(qv);
	n = bsxfun(@rdivide, qv, qvnorm);
end