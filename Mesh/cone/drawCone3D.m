function drawCone3D(W, color, addOrigin)

if addOrigin
    origin = [0 0 0];
    data = [origin; W'];
else
    data = W';
end

if rank(bsxfun(@minus, W, W(:,1))) >= 3
    K = convhull(data(:,1), data(:,2), data(:,3));
    h = trisurf(K, data(:,1), data(:,2), data(:,3), 'Facecolor',color);
else
    if size(data, 1) >= 3
        [U,S]=svd(   bsxfun(@minus,data,mean(data)),   0);
        K = convhull(U*S(:,1:2));
        patch(data(K, 1), data(K, 2), data(K, 3), color);
    else
        patch(data(:, 1), data(:, 2), data(:, 3), color);
    end
end

h.FaceColor = color;
h.FaceAlpha = 0.5;
% axis equal;

plot3(W(1, :), W(2, :), W(3, :), '.', 'markersize', 20);

xlabel('X');
ylabel('Y');
zlabel('Z');

end