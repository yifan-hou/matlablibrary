% rotation matrix to exponential coordinate (so3)
% input:
%   R: 3 x 3
% output:
%   n: 3 x 1
function n = SO32so3(R)
    % these parts are the same as mat2aa
    theta = acos((trace(R)-1)/2);
    if abs(theta) < 1e-7
        n = [1 0 0]';
    else
        n = [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)]/2/sin(theta);
    end
    n = n*theta;
end