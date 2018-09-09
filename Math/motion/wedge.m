% wedge operation.
% 	cross(v, u) = v_wedge * u
%
% input:
% 	v: 3 x 1
% output:
%	v_wedge: 3 x 3
function v_wedge = wedge(v)
	v_wedge = [    0  -v(3)   v(2);
			    v(3)      0  -v(1);
			   -v(2)   v(1)     0];
end