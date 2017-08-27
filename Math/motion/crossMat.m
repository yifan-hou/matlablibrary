% calculate the matrix for cross product.
% given b, cross(v, b) = m*b
% input:
% 	v: 3x1
% output:
% 	m: 3x3
function m = crossMat(v)
 m = [0		-v(3)	 v(2);
  	  v(3)	 0		-v(1);
  	 -v(2)	 v(1)	 0];
end