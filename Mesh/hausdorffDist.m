% calculate the hausdorff distance between two polygons
% This is a plain, not clever implimentation by definition
% input
% 	P1: 3xN1
% 	P2: 3xN2
% 	single_side: if true, only calculate distance from P1 to P2
function [dist, i, j] = hausdorffDist(P1, P2, single_side)

if nargin < 3
	single_side = false;
end

N1 = size(P1, 2);
dist1 = zeros(1, N1);
for i = 1:N1
	diff12 = bsxfun(@minus, P2, P1(:,i));
	dist1(i) = min(normByCol(diff12));
end
[dist1, id1] = max(dist1);

if single_side
	dist = dist1;
else
	N2 = size(P2, 2);
	dist2 = zeros(1, N2);
	for i = 1:N2
		diff21 = bsxfun(@minus, P1, P2(:,i));
		dist2(i) = min(normByCol(diff21));
	end
	[dist2, id2] = max(dist2);

	dist = max(dist1, dist2);
end


% find out id of the points that produce dist
if nargout <= 1
	return;
end
if single_side
	i = id1;
	diff12 = bsxfun(@minus, P2, P1(:,i));
	[~, j] = min(normByCol(diff12));
else
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

end