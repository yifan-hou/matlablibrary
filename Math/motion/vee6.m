% vee operation.
%
% input:
%   se3: 4 x 4
% output:
%   t: 6 x 1
function t = vee6(se3)
    t = [se3(1:3, 4); vee(se3(1:3,1:3))];
end