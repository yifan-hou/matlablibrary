% R1: 2xn, generators of a 2D convex cone
% R2: 2xn, generators of a 2D convex cone
% R12: generators of the intersection of R1 and R2
% R1_: generators of R1-R2
% R2_: generators of R2-R1
function [R12, R1_, R2_] = coneIntersection2D(R1, R2)
% simplify input cones
R1 = removeRedundantRays2D(R1);
R2 = removeRedundantRays2D(R2);

TOL = 1e-5;

xx = mean(R1')';
zz = cross(xx, [1; 0]);
if norm(zz) < TOL
    zz = cross(xx, [0; 1]);
end
yy = cross(zz, xx);

R1_new = [xx'; yy']*R1;
R2_new = [xx'; yy']*R2;

angles1 = atan2(R1_new(2,:), R1_new(1,:));
angles2 = atan2(R2_new(2,:), R2_new(1,:));

[angle_1_min, id1_min] = min(angles1);
[angle_1_max, id1_max] = max(angles1);

[angle_2_min, id2_min] = min(angles2);
[angle_2_max, id2_max] = max(angles2);

if angle_2_min < angle_1_min - TOL
    if angle_2_max < angle_1_min - TOL
        R12 = [];
        R1_ = R1;
        R2_ = R2;
    elseif angle_2_max < angle_1_min + TOL
        R12 = R1(:, id1_min);
        R1_ = R1;
        R2_ = R2;
    elseif angle_2_max < angle_1_max - TOL
        R12 = [R1(:, id1_min) R2(:, id2_max)];
        R1_ = [R2(:, id2_max) R1(:, id1_max)];
        R2_ = [R2(:, id2_min) R1(:, id1_min)];
    elseif angle_2_max < angle_1_max + TOL
        R12 = R1;
        R1_ = R1(:, id1_max);
        R2_ = [R2(:, id2_min) R1(:, id1_min)];
    else
        R12 = R1;
        R1_ = [];
        if angle_2_max - angle_1_max > angle_1_min - angle_2_min
            R2_ = [R1(:, id1_max) R2(:, id2_max)];
        else
            R2_ = [R2(:, id2_min) R1(:, id1_min)];
        end
    end
elseif angle_2_min < angle_1_min + TOL
    if angle_2_max < angle_1_min + TOL
        R12 = R1(:, id1_min);
        R1_ = R1;
        R2_ = R2;
    elseif angle_2_max < angle_1_max - TOL
        R12 = [R1(:, id1_min) R2(:, id2_max)];
        R1_ = [R2(:, id2_max) R1(:, id1_max)];
        R2_ = [R2(:, id2_min) R1(:, id1_min)];
    elseif angle_2_max < angle_1_max + TOL
        R12 = R1;
        R1_ = R1(:, id1_max);
        R2_ = [R2(:, id2_min) R1(:, id1_min)];
    else
        R12 = R1;
        R1_ = [];
        if angle_2_max - angle_1_max > angle_1_min - angle_2_min
            R2_ = [R1(:, id1_max) R2(:, id2_max)];
        else
            R2_ = [R2(:, id2_min) R1(:, id1_min)];
        end
    end
end

% think about [] ()
% get rid of redundancy