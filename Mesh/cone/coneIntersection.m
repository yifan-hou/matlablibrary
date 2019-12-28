% Find the intersection two polyhedral convex cones in 3D space.
%
% Note: the found representation may not be the minimal representation. Some rows
% of A might be redundant.
%
% R1: d x m1 matrix, the m1 rays that define the first cone.
% R2: d x m2 matrix, the m2 rays that define the second cone.
% R: d x m matrix, m rays that define the intersection of R1 and R2
function [R] = coneIntersection(R1, R2)

A = [facetEnumeration(R1); facetEnumeration(R2)];
R = vertexEnumeration(A);
