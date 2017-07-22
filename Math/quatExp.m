% Quaternion exponential
% Inputs set 1
% 	a1: 4xN quaternion. It is assumed to be a pure quaternion. not necessarily unit
% Inputs 2
% 	a1: 3xN vector, ntheta, the vector part of a pure quaternion.
% Inputs 3
% 	a1, a2, a3: scalar compenents of ntheta
% Outputs
% 	q: 4xN unit quaternion
function q = quatExp(a1, a2, a3)
if nargin == 1
	if size(a1, 1) == 4
		a1 = a1(2:4,:);
	end
	theta = normByCol(a1);
	n = bsxfun(@rdivide, a1, theta);
elseif nargin == 1
	theta = norm([a1 a3 a3]);
	n = [a1 a2 a3]'/theta;
end
	
q = [cos(theta); bsxfun(@times, sin(theta), n)];

end