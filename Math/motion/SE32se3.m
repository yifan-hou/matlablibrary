% implementation of Rodriguez's formula
% input:
%   SE3: 4x4 homogeneous coordinate
% output:
%   se3: 6x1 twist coordinate
function twist = SE32se3(SE3)
    p = SE3(1:3, 4);
    omega = SO32so3(SE3(1:3,1:3));
    theta = norm(omega);
    if theta < 1e-7
        twist = [p;0;0;0];
    else
        omega = omega/theta;
        v = ((eye(3)-expm(wedge(omega*theta)))*wedge(omega)+omega*(omega')*theta)\p;
        twist = [v; omega]*theta;
    end
end