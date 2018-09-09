% normalize each row vector of a matrix
function normalized = normalizeByRow(M)
    normalized = bsxfun(@rdivide, M, normByRow(M));
end