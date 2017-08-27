% Axis-angle to matrix
% input:
% 	theta: scalar
% 	n: 3 x 1
% output:
%	m: 3x3
function m = aa2mat(theta, n)
	n = n/norm(n);
	N = crossMat(n);
	m = eye(3) + sin(theta)*N + (1-cos(theta))*N*N;
end