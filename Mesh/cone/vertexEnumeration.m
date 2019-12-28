% Enumerate rays for a 3D cone given its facets.
%
% Specifically, given a homogeneous polyhedral convex cone described by
%    {x: Ax <= 0},
% Find its ray description {y: y=Rx, x >= 0}
%
% Currently the part that removes redundancy only works for 3D cones.
%
%   Examples:
%       A = [0 1 0; 1 0 0];
%       R = VertexEnumeration(A);
%
% This is an implementation of Double Description Method, based on
%   https://inf.ethz.ch/personal/fukudak/lect/pclect/notes2014/PolyComp2014.pdf
%   Lemma 9.1
function [R] = VertexEnumeration(A)

[kRowsA, kDim] = size(A);
% Trivial initial DD pair
R = [eye(kDim) -ones(kDim, 1)]; % initially, R expands the whole space

% ID_ALL = 1:kRowsA;
% while length(K) < kRowsA
for i = 1:kRowsA
    % select any index i from {1, 2, ..., kRowsA}\K
    Ai = A(i, :);
    % this new hyperplane, Ai, divides rays in R into three groups
    projection = Ai*R;
    J_minus = projection < -1e-10;
    J_plus = projection > 1e-10;
    J_zero = ~(J_minus | J_plus);
    % new R is composed of rays of J_minus, rays of J_zero, and some new vectors
    R1 = R(:, J_minus | J_zero);
    R2 = [];
    id_plus = find(J_plus);
    id_minus = find(J_minus);
    for j = 1:sum(J_plus)
        for j_ = 1:sum(J_minus)
            r_jj_ = (Ai*R(:, id_plus(j)))*R(:, id_minus(j_)) - (Ai*R(:, id_minus(j_)))*R(:, id_plus(j));
            R2 = [R2 r_jj_];
        end
    end
    % update
    R = [R1 R2];
end


% remove redundancy
% only work if kDim = 3
assert(kDim == 3);
R = normc(R);

TOL = 1e-6;
r = rank(R, TOL);
if r == 0
    R = [];
    return;
end

% remove zeros
Rnorm = normByCol(R);
R(:, Rnorm < TOL) = [];

if r == 1
    if size(R, 2) == 1
        return;
    end
    R = uniquetol(R', 10*TOL, 'ByRows', true)';
    return;
end

p_rand = [];
if r == 2
    if size(R, 2) == 2
        return;
    end
    % convhull won't work for degeneration case
    % add a point to make a 3D polytope.
    while true
        p_rand = rand([3, 1]);
        if rank([R p_rand]) == 3
            break;
        end
    end
end

% now, rank = 3
if size(R, 2) == 3
    return;
end

R_polytope = [zeros(3,1) R p_rand];
K = convhull(R_polytope', 'simplify', true);
id1 = K == 1;
id_unique = [];
if any(any(id1))
    % The origin is outside of the hull
    id_all = K(any(id1, 2), :);
    id_unique = unique(id_all, 'stable');
else
    K_ = convhull(R_polytope');
    id1_ = K_ == 1;
    if any(any(id1_))
        % The origin is on the boundary of the hull
        id_all_ = K_(any(id1_, 2), :);
        id_unique = intersect(K, id_all_);
    else
        % origin is strictly inside the hull
        R = [eye(kDim), -ones(kDim, 1)];
        return;
    end
end

id_unique(id_unique == 1) = [];
id_unique(id_unique == 2+size(R, 2)) = [];
id_unique = id_unique - 1;
R = R(:, id_unique);

