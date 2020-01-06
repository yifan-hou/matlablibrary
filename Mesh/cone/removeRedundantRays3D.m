function R = removeRedundantRays3D(R)

TOL = 1e-6;
r = rank(R, TOL);
if r == 0
    R = [];
    return;
end

% remove zeros, then normalize
Rnorm = normByCol(R);
R(:, Rnorm < TOL) = [];
R = normc(R);
R = uniquetol(R', 10*TOL, 'ByRows', true)';

if r == 1
    return;
end

if r == 2
    if size(R, 2) == 2
        return;
    end
    center = mean(R')';
    if norm(center) < 1e-6
        % whole plane
        x = R(:, 1);
        xx = R(:, 2);
        z = cross(x, xx);
        y = cross(z, x);
        R = [x, y, -x-y];
        return;
    end
    center = center/norm(center);
    origin = zeros(3,1);
    origin_ = -1e-5*center;
    R_polytope = [origin R];
    R_polytope_ = [origin_ R];

    % at least three vectors on a plane
    [U, S] = svd(bsxfun(@minus, R_polytope', mean(R_polytope')),   0);
    K = convhull(U*S(:, 1:2), 'simplify', true);
    [U, S] = svd(bsxfun(@minus, R_polytope_', mean(R_polytope_')),   0);
    K_ = convhull(U*S(:, 1:2), 'simplify', true);
    assert(K(1) == K(end));
    K(end) = [];
    K_(end) = [];
    if any(K_ == 1)
        % cone or half plane
        wrapN = @(x, N) (1 + mod(x-1, N));
        origin_id = find(K_ == 1);
        left_id = wrapN(origin_id+1, length(K_));
        right_id = wrapN(origin_id-1, length(K_));
        id_unique = [K_(left_id), K_(right_id)];
        if norm(R_polytope_(:, K_(left_id)) + R_polytope_(:, K_(right_id))) < 1e-6
            % half plane
            id_others = setdiff(K_, [K_(origin_id) id_unique]);
            id_unique = [id_unique id_others(1)];
        end
        R = R_polytope(:, id_unique);
    else
        % whole plane
        % just find a basis
        x = R_polytope_(:, K_(1));
        xx = R_polytope_(:, K_(2));
        z = cross(x, xx);
        y = cross(z, x);
        R = [x, y, -x-y];
    end
    return;
end

% now, rank = 3
if size(R, 2) == 3
    return;
end

center = mean(R')';
if norm(center) < 1e-6
    % whole space
    R = [eye(3), -ones(3, 1)];
    return;
end

center = center/norm(center);
origin = zeros(3,1);
origin_ = -1e-5*center;
R_polytope = [origin R];
R_polytope_ = [origin_ R];
K = convhull(R_polytope', 'simplify', true);
K_ = convhull(R_polytope_', 'simplify', true);
id1 = K == 1;
id1_ = K_ == 1;
id_all_ = K_(any(id1_, 2), :);
id_unique = unique(id_all_, 'stable');
id_unique(id_unique == 1) = [];
if any(any(id1_))
    % Origin is on the boundary.
    % Three possible origin locations: vertex, edge, facet
    % check by counting anti-podal pairs
    id_antipodal = antiPodals(R);
    num_anitpodal = size(id_antipodal, 1);
    if num_anitpodal == 0
        % origin is a vertex or on a facet
        R_ = R_polytope_(:, id_unique);
        if rank(R_) < 3
            % facet
            x = R_(:, 1);
            z = cross(x, R_(:, 2));
            z = z/norm(z);
            if z'*center < 0
                z = -z;
            end
            y = cross(z, x);
            R = [x y -x-y z];
        else
            % vertex
            % simplify using 2D convhull
            if size(R_, 2) > 3
                proj_z = center'*R_;
                if all(proj_z > 0)
                    R_intersects = bsxfun(@rdivide, R_, proj_z);
                    z = center;
                    zz = rand(3, 1);
                    x = cross(z, zz);
                    x = x/norm(x);
                    y = cross(z, x);
                    R_proj_xy = [x'; y'] * R_intersects;
                    K = convhull(R_proj_xy', 'simplify', true);
                    K(end) = [];
                    R_ = R_(:, K);
                end
            end
            R = R_;
        end
    elseif num_anitpodal == 1
        % origin is on an edge or a facet
        z = R(:, id_antipodal(1));
        x = cross(center, z);
        y = cross(z, x);
        id_rest = setdiff(1:size(R,2), id_antipodal);
        R_proj_xy = [x'; y'] * R(:, id_rest);
        R_proj_xy = normc(R_proj_xy);
        R_proj_angles = panAngle(R_proj_xy);
        [~, max_id] = max(R_proj_angles);
        [~, min_id] = min(R_proj_angles);
        if abs(R_proj_angles(max_id) - pi) < 1e-6
            % facet
            x_ = z;
            xx_ = R(:, id_rest(max_id));
            z_ = cross(x_, xx_);
            y_ = cross(z_, x_);
            R = [x_, y_, -x_-y_, y];
        else
            % edge
            R = R(:, [id_antipodal id_rest(max_id) id_rest(min_id)]);
        end
    elseif num_anitpodal == 2
        % origin is on a facet
        % use 3 of the four anitpodals as plane generator, plus the center vector
        % to point in the right half
        g1 = R(:, id_antipodal(1, 1));
        gg = R(:, id_antipodal(2, 1));
        gz = cross(g1, gg);
        g2 = cross(gz, g1);
        g3 = -g1-g2;

        R = [g1 g2 g3 center];
    end
else
    % The origin is inside of the hull
    R = [eye(3), -ones(3, 1)];
end

end


function ids = antiPodals(R)
    n = size(R, 2);
    ids = [];
    id_all = 1:size(R, 2);
    while length(id_all) >= 2
        R_ = bsxfun(@plus, R(:, id_all), R(:, id_all(1)));
        id = find(normByCol(R_) < 1e-6);
        nid = length(id);
        if nid > 0
            assert(nid == 1);
            ids = [ids; id_all(1) id_all(id)];
            id_all(id) = [];
        end
        id_all(1) = [];
    end
end


%!
%! Find order of 2D vectors within a half plane. Compute rotation angles in
%! (0 ~ pi) degree
%!
%! @param      v     2xn vectors
%!
%! @return     1xn angles in rad
%!
function angles = panAngle(v)
    angles_raw = atan2(v(2,:), v(1,:));
    angles_raw(angles_raw < 0) = angles_raw(angles_raw < 0) + 2*pi; % 0~ 2pi

    % now try to find one extreme vector (one edge of the cone)
    for i = 1:length(angles_raw)
        angles = angles_raw - (angles_raw(i));
        angles(angles < 0) = angles(angles < 0) + 2*pi; % 0~ 2pi

        if max(angles) < pi + 1e-7
            return;
        end
    end
    % shouldn't arrive here
    assert(false);
end