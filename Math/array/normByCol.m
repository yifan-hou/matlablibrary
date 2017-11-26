% norm of each column of a matrix
function mynorm = normByCol(M)
    mynorm = (sqrt(sum((M).^2, 1)));
end