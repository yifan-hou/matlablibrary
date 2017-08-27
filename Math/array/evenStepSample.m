% sample points between [a, b] with distance approximately step.
% first sample = a, last sample = b.
% actual step length could be a little different with step
function samples = evenStepSample(a, b, step)
	n = floor(abs(b - a)/step);
	if n==0
		n=1;
	end
	step = (b-a)/n;
	samples = a + (0:n)*step;
end
