% input:
%   R: 2x2 rotation matrix
%   p: 2x1 position vector
% output:
%   adj: 3x3 adjoint transformation for SE2
function Adj = SE22Adj(R, p)
    Adj = zeros(3);
    Adj(1:2,1:2) = R;
    Adj(1, 3) = p(2);
    Adj(2, 3) = -p(1);
    Adj(3, 3) = 1;
end