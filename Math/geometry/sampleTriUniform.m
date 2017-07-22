% sample points uniformly in a triangle
% input:
% 	a,b,c: 3 x 1 vector
% 	n: number of points to sample. default = 1
% output:
% 	p: 3 x n, sampled points

% https://math.stackexchange.com/questions/18686/uniform-random-point-in-triangle
		
function [p] = sampleTriUniform(a,b,c,n)
	if nargin < 4
		n = 1;
	end
	r1 = rand(1,n);
	r2 = rand(1,n);
	p  = a*(1-sqrt(r1)) + b*(sqrt(r1).*(1-r2)) + c*(r2.*sqrt(r1));
end