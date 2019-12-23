%
% Adj = SE32Adj(SE3), SE3 is 4x4 homogeneous coordinate, or
%
% Adj = SE32Adj(R, p), R is 3x3 rotation matrix, p is 3x1 position vector.
%
% output:
%   Adj: 6x6 adjoint transformation
function Adj = SE32Adj(arg1, arg2)
    if nargin == 1
        R = arg1(1:3, 1:3);
        p = arg1(1:3, 4);
    else
        R = arg1;
        p = arg2;
    end
    Adj = zeros(6);
    Adj(1:3,1:3) = R;
    Adj(4:6, 4:6) = R;
    Adj(1:3, 4:6) = wedge(p) * R;
end