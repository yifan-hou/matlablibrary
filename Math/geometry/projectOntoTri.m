% In 3D space, project a point P to the 
% plane defined by points A,B and C.
% Then check if the projection is within
% that triangle ABC.
% input
% 	A,B,C: 3 by 1 vectors
% 	P: 3 by n vectors. n is the number of points 
% 		to check.
% output:
% 	pprj: 3 by n vectors.
% 	in: 1 by n. True if P is within the triangle. (optional)

% https://math.stackexchange.com/questions/544946/determine-if-projection-of-3d-point-onto-plane-is-within-a-triangle

function [pprj, in] = projectOntoTri(A, B, C, P)
N  = size(P,2);

u  = B - A;
uu = repmat(u, [1 N]);

v  = C - A;
vv = repmat(v, [1 N]);

n  = cross(u,v);
n2 = dot(n,n);

w = P - A*ones(1, N);

gamma = cross(uu,w,1)'*n/n2;
beta  = cross(w,vv,1)'*n/n2;
alpha = 1 - gamma - beta;

pprj = A*(alpha') + B*(beta') + C*(gamma');

if nargout <= 1
	return;
end

in = (alpha >= 0)&(alpha <= 1)&(beta >= 0)&(beta <= 1)&(gamma >= 0)&(gamma <= 1);
in = in';

end
