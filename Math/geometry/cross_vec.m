% fast cross without matlab overhead
% a, b must be vectors of length 3
function c = cross_vec(a,b)

c = [a(2).*b(3)-a(3).*b(2);
        a(3).*b(1)-a(1).*b(3);
        a(1).*b(2)-a(2).*b(1)];
end