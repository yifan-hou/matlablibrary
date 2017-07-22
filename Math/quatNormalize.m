% quaternion normalization
% input:
% 	q: 4xm
% output:
%	q: 4xm
function q = quatNormalize(q)
	qNorm = normByCol(q);
	q = bsxfun(@rdivide, q, qNorm);
end