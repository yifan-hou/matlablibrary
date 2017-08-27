% Axis-angle to quaternion
% input:
% 	theta: 1 x m
% 	n: 3 x m or 3x1
% output:
%	q: 4 x m
function q = aa2quat(theta, n)
	n = n/normByCol(n);
	if size(n, 2) == 1
		q = [cos(theta/2); n*sin(theta/2)];
	else
		q = [cos(theta/2); bsxfun(@times, sin(theta/2), n)];
	end
end