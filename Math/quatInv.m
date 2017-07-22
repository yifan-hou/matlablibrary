% quaternion inverse
% input:
% 	q: 4xm
% output:
%	q: 4xm
function q = quatInv(q)
	q(2:4,:) = -q(2:4,:);
end