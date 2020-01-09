% a, b must be vectors of length 2
function c = cross2(a,b)

c = [0; 0; a(1).*b(2)-a(2).*b(1)];
end