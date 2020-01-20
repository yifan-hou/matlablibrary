% Transform vec by SE3.
% vec: 3xn
function v = SE3OnVec(SE3, vec)
    v = SE3 * [vec; ones(1, size(vec,2))];
    v = v(1:3, :);
end