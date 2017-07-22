% Axis-angle to quaternion
% input:
% 	theta: 1 x m
% 	n: 3 x m
% output:
%	q: 4 x m
function q = aa2quat(theta, n)
	q = [cos(theta/2); bsxfun(@times, sin(theta/2), n)];
end