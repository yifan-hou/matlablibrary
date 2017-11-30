% quaternion to Axis-angle
% input:
% 	q: 4 x m
% output:
%	theta: 1 x m
% 	n: 3 x m, unit vectors
function [theta, n] = quat2aa(q)
	theta = 2*acos(q(1,:));
	qv = q(2:4,:);
	qvnorm = ones(3,1)*normByCol(qv);
    n = qv./qvnorm; % to be compatible with symbolic
% 	n = bsxfun(@rdivide, qv, qvnorm);
end