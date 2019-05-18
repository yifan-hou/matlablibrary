% rotation matrix to Axis-angle
% input:
%   R: 3 x 3
% output:
%   theta: 1 x m
%   n: 3 x m, unit vectors
function [theta, n] = SO32aa(R)
    theta = acos((trace(R)-1)/2);
    if abs(theta) < 1e-7
        n = [1 0 0]';
    else
        n = [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)]/2/sin(theta);
    end
end