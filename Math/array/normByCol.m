% norm of each column of a matrix
function mynorm = normByCol(M)
	[n,~] = size(M);
    if n == 1
        mynorm = abs(M);
    else
        mynorm = (sqrt(sum((M).^2)));
    end

end