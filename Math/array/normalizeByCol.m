% normalize each column vector of a matrix
function normalized = normalizeByCol(M)
	[n,~] = size(M);
	normalized = bsxfun(@rdivide, M, normByCol(M));
end