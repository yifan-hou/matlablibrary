% a, b must be 2 x n matrices
function c = cross2(a,b)
    c = a(1,:).*b(2,:) - a(2,:).*b(1,:);
end
