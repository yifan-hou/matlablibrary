% fast cross without matlab overhead
% a, b must be 3xn matrices
function c = cross_mat(a,b)
c(3,:) = a(1,:).*b(2,:)-a(2,:).*b(1,:);
    c(1,:) = a(2,:).*b(3,:)-a(3,:).*b(2,:);
    c(2,:) = a(3,:).*b(1,:)-a(1,:).*b(3,:);
end