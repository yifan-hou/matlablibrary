% norm of each row of a matrix
function mynorm = normByRow(M)
    [~,n] = size(M);
    if n == 1
        mynorm = abs(M);
    else
        mynorm = (sqrt(sum((M').^2)))';
    end
end