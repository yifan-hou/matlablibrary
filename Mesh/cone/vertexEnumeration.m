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
function [R] = vertexEnumeration(A)

[kRowsA, kDim] = size(A);
% only works if kDim = 3 (due to the redundancy removal)
assert(kDim == 3);

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
    if isempty(R)
        return;
    end
    % remove redundancy
    R = removeRedundantRays3D(R);
end


