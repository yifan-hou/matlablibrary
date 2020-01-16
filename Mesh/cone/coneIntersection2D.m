% R1: 2xn, generators of a 2D closed convex cone
% R2: 2xn, generators of a 2D closed convex cone
% R12: generators of the intersection of R1 and R2
% R1_: generators of R1-R2. If there are two cones, choose the larger one
% R2_: generators of R2-R1. If there are two cones, choose the larger one
function [R12, R1_, R2_] = coneIntersection2D(R1, R2)
% simplify input cones
R1 = normc(R1);
R2 = normc(R2);

TOL = 1e-5;

xx = mean(R1, 2);

% I haven't consider the case of line
assert(norm(xx) > 1e-4);
assert(norm(mean(R2, 2)) > 1e-4);

zz = cross([xx; 0], [1; 0; 0]);
if norm(zz) < TOL
    zz = cross([xx; 0], [0; 1; 0]);
end
yy = cross(zz, [xx; 0]);

yy = yy(1:2);

R1_new = [xx'; yy']*R1;
R2_new = [xx'; yy']*R2;

angles1 = atan2(R1_new(2,:), R1_new(1,:));
angles2 = atan2(R2_new(2,:), R2_new(1,:));

[angle_1_min, id1_min] = min(angles1);
[angle_1_max, id1_max] = max(angles1);

[angle_2_min, id2_min] = min(angles2);
[angle_2_max, id2_max] = max(angles2);

if angle_2_max - angle_2_min > pi
    angles2(angles2 < 0) = angles2(angles2 < 0) + 2*pi;
    [angle_2_min, id2_min] = min(angles2);
    [angle_2_max, id2_max] = max(angles2);
end

IsARay1 = true;
IsARay2 = true;
if angle_1_max - angle_1_min > TOL
    IsARay1 = false;
end
if angle_2_max - angle_2_min > TOL
    IsARay2 = false;
end

r1min = R1(:, id1_min);
r1max = R1(:, id1_max);
r2min = R2(:, id2_min);
r2max = R2(:, id2_max);

if angle_2_min < angle_1_min - TOL
    if angle_2_max < angle_1_min - TOL
        R12 = [];
        R1_ = R1;
        R2_ = R2;
    elseif angle_2_max < angle_1_min + TOL
        R12 = r1min;
        if IsARay1
            R1_ = [];
        else
            R1_ = R1;
        end
        R2_ = R2;
    elseif angle_2_max < angle_1_max - TOL
        R12 = [r1min r2max];
        R1_ = [r2max r1max];
        R2_ = [r2min r1min];
    elseif angle_2_max < angle_1_max + TOL
        R12 = R1;
        R1_ = [];
        R2_ = [r2min r1min];
    else
        R12 = R1;
        R1_ = [];
        if angle_2_max - angle_1_max > angle_1_min - angle_2_min
            R2_ = [r1max r2max];
        else
            R2_ = [r2min r1min];
        end
    end
elseif angle_2_min < angle_1_min + TOL
    if angle_2_max < angle_1_min + TOL
        R12 = r1min;
        if IsARay1
            R1_ = [];
        else
            R1_ = R1;
        end
        R2_ = [];
    elseif angle_2_max < angle_1_max - TOL
        R12 = [r1min r2max];
        R1_ = [r2max r1max];
        R2_ = [];
    elseif angle_2_max < angle_1_max + TOL
        R12 = R1;
        R1_ = [];
        R2_ = [];
    else
        R12 = R1;
        R1_ = [];
        R2_ = [r1max r2max];
    end
elseif angle_2_min < angle_1_max - TOL % IsARay1 = false
    if angle_2_max < angle_1_max - TOL
        R12 = R2;
        if angle_2_min - angle_1_min > angle_1_max - angle_2_max
            R1_ = [r1min r2min];
        else
            R1_ = [r2max r1max];
        end
        R2_ = [];
    elseif angle_2_max < angle_1_max + TOL
        R12 = R2;
        R1_ = [r1min r2min];
        R2_ = [];
    else
        R12 = [r2min r1max];
        R1_ = [r1min r2min];
        R2_ = [r1max r2max];
    end
elseif angle_2_min < angle_1_max + TOL % IsARay1 = false
    if angle_2_max < angle_1_max + TOL
        R12 = R2;
        R1_ = R1;
        R2_ = [];
    else
        R12 = r2min;
        R1_ = R1;
        R2_ = R2;
    end
else
    R12 = [];
    R1_ = R1;
    R2_ = R2;
end

% get rid of redundancy
if size(R12, 2) == 2
    if norm(R12(:, 1) - R12(:, 2)) < TOL
        R12 = R12(:, 1);
    end
end

if size(R1_, 2) == 2
    if norm(R1_(:, 1) - R1_(:, 2)) < TOL
        R1_ = R1_(:, 1);
    end
end

if size(R2_, 2) == 2
    if norm(R2_(:, 1) - R2_(:, 2)) < TOL
        R2_ = R2_(:, 1);
    end
end
