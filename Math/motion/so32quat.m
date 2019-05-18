% so3 to quaternion
% input:
%   so3: 3 x 1
% output:
%   q: 4 x 1
function q = so32quat(so3)
    theta = norm(so3);
    if theta < 1e-7
        q = [1 0 0 0]';
    else
        omega = so3/theta;
        q = [cos(theta/2); sin(theta/2)*omega];
    end
end