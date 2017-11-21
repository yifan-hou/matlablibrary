% quaternion inverse
% input:
% 	q: 4xm
% output:
%	q: 4xm
function qi = quatInv(q)
	A = [1  0  0  0;
		 0 -1  0  0;
		 0  0 -1  0;
		 0  0  0 -1];
	qi = A*q;
	% q(2:4,:) = -q(2:4,:);
end