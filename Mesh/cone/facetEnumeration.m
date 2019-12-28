% Enumerate facets for a cone given its ray representation.
%
% Specifically, given a homogeneous polyhedral convex cone described by
%    {y: y=Rx, x >= 0}
% Find its facet description
%    {x: Ax <= 0},
%
% Note: this representation may not be the minimal representation. Some rows
% of A might be redundant.
%
%   Examples:
%       R = [0 1 0; 1 0 0];
%       A = FacetEnumeration(R);
%
function [A] = facetEnumeration(R)

R_ = vertexEnumeration(R');
A = R_';
