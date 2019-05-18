% wedge operation for displacements.
%
% input:
%   t: 6 x 1
% output:
%   t_wedge: 4 x 4
function t_wedge = wedge6(t)
    t_wedge = [   0   -t(6)   t(5)  t(1);
                t(6)     0   -t(4)  t(2);
               -t(5)   t(4)     0   t(3);
                  0      0      0     0];
end