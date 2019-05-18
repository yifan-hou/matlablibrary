% vee operation.
%
% input:
% 	so3: 3 x 3
% output:
%	v: 3 x 1
function v = vee(so3)
	assert(norm(so3 + so3') < 1e-6);
	v = [so3(3,2); so3(1,3); so3(2,1)];
end