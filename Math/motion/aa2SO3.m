% Axis-angle to matrix
% input:
% 	theta: scalar
% 	n: 3 x 1
% output:
%	SO3: 3x3
function m = aa2SO3(theta, n)
	n = n/norm(n);
	N = wedge(n);
	m = eye(3) + sin(theta)*N + (1-cos(theta))*N*N;
end