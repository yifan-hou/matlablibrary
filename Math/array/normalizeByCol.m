% normalize each column vector of a matrix
function normalized = normalizeByCol(M)
	normalized = bsxfun(@rdivide, M, normByCol(M));
end