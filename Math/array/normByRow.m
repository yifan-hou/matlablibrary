% norm of each row of a matrix
function mynorm = normByRow(M)
	mynorm = (sqrt(sum((M).^2, 2)));
end