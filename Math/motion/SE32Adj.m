% implementation of Rodriguez's formula
% input:
%   SE3: 4x4 homogeneous coordinate
% output:
%   se3: 6x6 adjoint transformation
function Adj = SE32Adj(SE3)
    Adj = zeros(6);
    R = SE3(1:3, 1:3);
    p = SE3(1:3, 4);
    Adj(1:3,1:3) = R;
    Adj(4:6, 4:6) = R;
    Adj(1:3, 4:6) = wedge(p) * R;
end