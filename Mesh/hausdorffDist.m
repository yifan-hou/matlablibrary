% calculate the hausdorff distance between two polygons
% This is a plain, not clever implimentation by definition
% input
% 	P1: 3xN1
% 	P2: 3xN2
function [dist, i, j] = hausdorffDist(P1, P2)

N1 = size(P1, 2);
N2 = size(P2, 2);

dist1 = zeros(1, N1);
dist2 = zeros(1, N2);
for i = 1:N1
	diff12 = bsxfun(@minus, P2, P1(:,i));
	dist1(i) = min(normByCol(diff12));
end
for i = 1:N2
	diff21 = bsxfun(@minus, P1, P2(:,i));
	dist2(i) = min(normByCol(diff21));
end

[dist1, id1] = max(dist1);
[dist2, id2] = max(dist2);
dist = max(dist1, dist2);

if nargout <= 1
	return;
end

if dist1 > dist2
	i = id1;
	diff12 = bsxfun(@minus, P2, P1(:,i));
	[~, j] = min(normByCol(diff12));
else
	j = id2;
	diff21 = bsxfun(@minus, P1, P2(:,j));
	[~, i] = min(normByCol(diff21));
end

end