% vee operation.
%
% input:
% 	se3: 3 x 3
% output:
%	v: 3 x 1
function v = vee(se3)
	assert(norm(se3 + se3') < 1e-6);
	v = [se3(3,2); se3(1,3); se3(2,1)];
end