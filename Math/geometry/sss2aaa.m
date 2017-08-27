% calculate angles of a triangle, given length of 3 sides
function [A, B, C] = sss2aaa(a, b, c)
a2 = a*a;
b2 = b*b;
c2 = c*c;

A = acos((b2+c2-a2)/2/b/c);
if nargout == 1
	return;
end
B = acos((a2+c2-b2)/2/a/c);
C = acos((a2+b2-c2)/2/a/b);

end